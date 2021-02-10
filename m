Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB2316DE7
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 19:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhBJSGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 13:06:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:19693 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233199AbhBJSE2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 13:04:28 -0500
IronPort-SDR: OATUapw/TctPpfgwYIitU52itFbsVVktFlJONhgZGzDpx9eYnWFjDIadESlBmT0fGRizXrt85k
 PyXkJw9sejzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="246189800"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="246189800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:02:56 -0800
IronPort-SDR: IWazrkUP5rGUVxzdHsy7ZSs1uBnTfJjgAZH53SQiN9snK+aRMapwJYi0UFqEd0BH+IvWp71B0q
 sNGWjV7ohP5A==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380239191"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:02:55 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v20 0/7] Control-flow Enforcement: Indirect Branch Tracking
Date:   Wed, 10 Feb 2021 10:02:38 -0800
Message-Id: <20210210180245.13770-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement (CET) is a new Intel processor feature that blocks
return/jump-oriented programming attacks.  Details are in "Intel 64 and
IA-32 Architectures Software Developer's Manual" [1].

This is the second part of CET and enables Indirect Branch Tracking (IBT).
It is built on top of the shadow stack series.

Changes in v20:
- Pick up Reviewed-by tags.
- Rebase to Linus tree v5.11-rc7.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Indirect Branch Tracking patches v19:

    https://lkml.kernel.org/r/20210203225902.479-1-yu-cheng.yu@intel.com/

H.J. Lu (3):
  x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
  x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point
  x86/vdso: Insert endbr32/endbr64 to vDSO

Yu-cheng Yu (4):
  x86/cet/ibt: Update Kconfig for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode Indirect Branch Tracking support
  x86/cet/ibt: Handle signals for Indirect Branch Tracking
  x86/cet/ibt: Update ELF header parsing for Indirect Branch Tracking

 arch/x86/Kconfig                         |  1 +
 arch/x86/entry/vdso/Makefile             |  4 ++
 arch/x86/entry/vdso/vdso32/system_call.S |  3 ++
 arch/x86/include/asm/cet.h               |  3 ++
 arch/x86/kernel/cet.c                    | 59 +++++++++++++++++++++++-
 arch/x86/kernel/cet_prctl.c              |  5 ++
 arch/x86/kernel/fpu/signal.c             |  8 ++--
 arch/x86/kernel/process_64.c             |  8 ++++
 8 files changed, 86 insertions(+), 5 deletions(-)

-- 
2.21.0

