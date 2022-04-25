Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1A50E895
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244508AbiDYStu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Apr 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244559AbiDYSts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2022 14:49:48 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B22D6F495;
        Mon, 25 Apr 2022 11:46:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3F74020E34C9;
        Mon, 25 Apr 2022 11:46:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F74020E34C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650912403;
        bh=RD17CCIy6QCNVL2Ku4vGwqqqjkjUVEeOvlnQBknNKdk=;
        h=From:To:Cc:Subject:Date:From;
        b=SRkWH/aS0vCRkMsv95HA1EPqisy4h4OATs2Gdx086EcD34sDur3VEYyczGMDCejAp
         lN2bx9opiY+STevjb+zLRWpTjo/A4IHQRn7/rYsCNQmjZ4ETyC7jXwvG0fU4JpZCNp
         HIwuvFiNwww4IAWlh5o5Tmlizzf1mUem/wiuiSFI=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH v2 0/7] tracing/user_events: Update user_events ABI from
Date:   Mon, 25 Apr 2022 11:46:24 -0700
Message-Id: <20220425184631.2068-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series covers the changes that were brought up once user_events went into
5.18. The largest change is moving away from byte index to a bit index, as
first suggested by Mathieu Desnoyers.

The other changes are either fixes that have accumulated or found by Mathieu.

NOTE: The sample and self-tests do not build unless you manually install
user_events.h into usr/include/linux.

Link:
https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Psuedo code example of typical usage with the new ABI:
struct user_reg reg;

int page_fd = open("user_events_status", O_RDWR);
char *page_data = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, page_fd,
0);
close(page_fd);

int data_fd = open("user_events_data", O_RDWR);

reg.size = sizeof(reg);
reg.name_args = (__u64)"test";

ioctl(data_fd, DIAG_IOCSREG, &reg);
int status_id = reg.status_bit / 8;
int status_mask = 1 << (reg.status_bit % 8);
int write_id = reg.write_index;

struct iovec io[2];
io[0].iov_base = &write_id;
io[0].iov_len = sizeof(write_id);
io[1].iov_base = payload;
io[1].iov_len = sizeof(payload);

if (page_data[status_id] & status_mask)
	writev(data_fd, io, 2);

V2 Updates:
Changed from status_index and status_mask on user_reg to just status_bit.
Updated and added byte-wise and long-wise indexing pattern into docs.
Updated tests to use byte-wise index pattern.
Updated sample to show long-wise index pattern.

Beau Belgrave (7):
  tracing/user_events: Fix repeated word in comments
  tracing/user_events: Use NULL for strstr checks
  tracing/user_events: Use WRITE instead of READ for io vector import
  tracing/user_events: Ensure user provided strings are safely formatted
  tracing/user_events: Use refcount instead of atomic for ref tracking
  tracing/user_events: Use bits vs bytes for enabled status page data
  tracing/user_events: Update ABI documentation to align to bits vs
    bytes

 Documentation/trace/user_events.rst           |  86 ++++---
 include/linux/user_events.h                   |  15 +-
 kernel/trace/trace_events_user.c              | 212 ++++++++++++------
 samples/user_events/example.c                 |  25 ++-
 .../selftests/user_events/ftrace_test.c       |  47 +++-
 .../testing/selftests/user_events/perf_test.c |  11 +-
 6 files changed, 264 insertions(+), 132 deletions(-)


base-commit: 5cfff569cab8bf544bab62c911c5d6efd5af5e05
-- 
2.25.1

