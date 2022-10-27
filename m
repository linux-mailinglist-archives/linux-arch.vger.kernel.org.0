Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9660F42E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiJ0J6o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiJ0J6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 05:58:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 630EE9A9F6;
        Thu, 27 Oct 2022 02:57:50 -0700 (PDT)
Received: from anrayabh-desk.corp.microsoft.com (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3D1DF210CC07;
        Thu, 27 Oct 2022 02:57:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D1DF210CC07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666864670;
        bh=Bvmo3uopcCHqTy41GnJDIxmpJghyOohBNndaPK/207U=;
        h=From:To:Cc:Subject:Date:From;
        b=GuK58xEfqlzPOT12zgrPQ0v9aqqYhgJimibJuxL8K7MXXVFvxrbgyuNVm03gEN5LZ
         ShREypEUJbZUSHdP2rRGgvnURgHbHnxj6Iyv0QnQTt5hZ4Qmb37tvuam4kiK6ykkyj
         1d2DEvY182zQrWbe+qS0z3rw8e/8kqoVZSryg3j4=
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, daniel.lezcano@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     stanislav.kinsburskiy@gmail.com,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, mail@anirudhrb.com
Subject: [PATCH v2 0/2] Fix MSR access errors during kexec in root partition
Date:   Thu, 27 Oct 2022 15:27:27 +0530
Message-Id: <20221027095729.1676394-1-anrayabh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
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

Fixes a couple of MSR access errors seen during kexec in root partition
and opportunistically introduces a data structure for the reference TSC
MSR in order to simplify the code that updates that MSR.

New in v2:
1. Reverse the patch order as suggested by Michael. First introduce the
   new structure for reference tsc MSR and then use it in the hv_cleanup
   fix.
2. Use hv_{get,set}_register functions in hv_cleanup().

Anirudh Rayabharam (2):
  clocksource/drivers/hyperv: add data structure for reference TSC MSR
  x86/hyperv: fix invalid writes to MSRs during root partition kexec

 arch/x86/hyperv/hv_init.c          | 11 +++++++----
 drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
 include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
 3 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.34.1

