Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C855848B1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jul 2022 01:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiG1XdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jul 2022 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiG1XdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2022 19:33:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F676785B4;
        Thu, 28 Jul 2022 16:33:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id 04EBF20FE89F;
        Thu, 28 Jul 2022 16:33:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04EBF20FE89F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659051193;
        bh=OshzEQjcp6ojnzn5LYBE1eu+Sux/uhH/cej6HEpEacI=;
        h=From:To:Cc:Subject:Date:From;
        b=duK7k3kdRNu8EiO0bF/fGZpcVmVhaBthPG6vfHLTgpg1eGtKUD1B3YpYqa0MQGits
         ilsdQlFOYPSnY79642iiV0V7fYWc9gzZsNxz5RjVqrNEuXRSGBNVKD9t6WdAySb8+X
         xcU+y9fupa22/4MmtYju1MXKsvCjWehgRkyIb+T0=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH v3 0/6] tracing/user_events: Update user_events ABI from
Date:   Thu, 28 Jul 2022 16:33:03 -0700
Message-Id: <20220728233309.1896-1-beaub@linux.microsoft.com>
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

Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Psuedo code example of typical usage with the new ABI:
struct user_reg reg;

int page_fd = open("user_events_status", O_RDWR);
char *page_data = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, page_fd, 0);
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

V3 Updates:
Rebase to recent ftrace/core head.
Updated comments to show how index/bit to byte is calculated.
Changed to BIT() macro vs 1 << X.

Beau Belgrave (6):
  tracing/user_events: Use NULL for strstr checks
  tracing/user_events: Use WRITE instead of READ for io vector import
  tracing/user_events: Ensure user provided strings are safely formatted
  tracing/user_events: Use refcount instead of atomic for ref tracking
  tracing/user_events: Use bits vs bytes for enabled status page data
  tracing/user_events: Update ABI documentation to align to bits vs
    bytes

 Documentation/trace/user_events.rst           |  86 ++++---
 include/linux/user_events.h                   |  15 +-
 kernel/trace/trace_events_user.c              | 228 ++++++++++++------
 samples/user_events/example.c                 |  25 +-
 .../selftests/user_events/ftrace_test.c       |  47 +++-
 .../testing/selftests/user_events/perf_test.c |  11 +-
 6 files changed, 281 insertions(+), 131 deletions(-)


base-commit: 26b2da5fc0b41a9a6a5e30b858da28572a6f4cbc
-- 
2.25.1

