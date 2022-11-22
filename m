Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832646344EE
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 20:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiKVTyq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 14:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiKVTyU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 14:54:20 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A15A289C;
        Tue, 22 Nov 2022 11:54:17 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q1so14924773pgl.11;
        Tue, 22 Nov 2022 11:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPxpAxhUqBtt9Bb2GFNO22maEjXkf8gmlR2Dn1jeFJM=;
        b=X/SPX1PtlXVYLc0heh7tHCgHoFCjlZHOFuRBUyOXRQh67EEgWprUhgE/NeEogHmGNG
         k77NE/teiBmcacBvRcAr1e3ov9za76gkYZ4FqcSP3pynFJPg3GO3s7+uJDhvPQvB6inc
         1bMuH870nQINr+qfqqihGPu500ONjbteV0WbV4+J87k3wgRWsrxjpmDXAPkd5iYE+FIa
         JnDpGXP16hie9Rbgafuxzl3JsHy6my3Zkn2aOCF11S+NOgM0nbDTQ5OXAHssZTHAZ7i0
         om1/qOAIYkg81ZCuCfhfrnJ5phfbfnQz2QXln46P7xPupzhwCIJyCN+fj1Fd+4CfHhk1
         scHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPxpAxhUqBtt9Bb2GFNO22maEjXkf8gmlR2Dn1jeFJM=;
        b=sx4zert9g8qg+aJdHpFJmT9wckCEbzLSMnwajQ3qvKnWHtszMSCAoe1+yTX4gUOGUC
         2oFQkonfXUMbsnF7OAJHAvsc8tgoCNKrnIsuy2G6R6pHAOXnqyaxa5pVC1rIOUdNAbcN
         XztVxEmTTIcjHhnZPZUpF3PtD7jnzyVWNkYXfNgjVppr3ozAHFlRn4CmadR5y24E8cki
         rVWrmJu+fBLQGA30bRBzecgn2uCCwHLfb0aFPECnhdoqCSXs0KCerupy8PxQQda+CXAg
         QR7HiM2h7hEwEX+51LZDZ42fhJEje7y4lBJ/dDVdKnY/7KO+uf1NGXcVIIrYlWOPWMYh
         Xdvg==
X-Gm-Message-State: ANoB5png2IebihAhyLfJ+utNS6mVh0WW6+GFWzXUY1+NChEPZcVl1003
        ZrwapfU7n5RR46wkwDA5LWg=
X-Google-Smtp-Source: AA0mqf73rcPZYB/HcgS5oMbH4KTi0vnqLjzX+pRLg1eJ0P4yIPFmxsE0XNpu9iGP+6uN+foHQon7pA==
X-Received: by 2002:a63:4f63:0:b0:476:df56:b35e with SMTP id p35-20020a634f63000000b00476df56b35emr6035739pgl.449.1669146856798;
        Tue, 22 Nov 2022 11:54:16 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a8-20020a63d408000000b00460fbe0d75esm9699252pgh.31.2022.11.22.11.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:54:16 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 0/3] kprobes: notrace enhancements
Date:   Tue, 22 Nov 2022 11:53:26 -0800
Message-Id: <20221122195329.252654-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

There are inconsistencies and some issues in marking functions as
notrace. On one hand, all inline functions are marked as "notrace" and
some libraries cannot be traced. At the same time, some functions should
not be traced but are not marked as notrace.

These patch address issues that I encountered during work on an
automatic tracing tool.

Nadav Amit (3):
  kprobes: Mark descendents of core_kernel_text as notrace
  lib/usercopy: Allow traceing of usercopy, xarray, iov_iter
  compiler: inline does not imply notrace

 arch/arm/kernel/process.c             | 2 +-
 arch/ia64/mm/init.c                   | 2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 arch/x86/um/mem_32.c                  | 2 +-
 include/asm-generic/sections.h        | 6 +++---
 include/linux/compiler_types.h        | 2 +-
 include/linux/kallsyms.h              | 6 +++---
 include/linux/mm.h                    | 2 +-
 lib/Makefile                          | 3 +++
 9 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.25.1

