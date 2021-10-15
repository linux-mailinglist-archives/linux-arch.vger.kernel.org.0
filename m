Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935C542FAF5
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbhJOS33 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 14:29:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:65297 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237667AbhJOS32 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Oct 2021 14:29:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="214900521"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="214900521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 11:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="571833563"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 15 Oct 2021 11:27:05 -0700
Received: from alobakin-mobl.ger.corp.intel.com (dkaczkow-MOBL2.ger.corp.intel.com [10.213.18.206])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 19FIR2T7023903;
        Fri, 15 Oct 2021 19:27:02 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] x86: Various clean-ups in support of FGKASLR
Date:   Fri, 15 Oct 2021 20:27:01 +0200
Message-Id: <20211015182701.13573-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013175742.1197608-1-keescook@chromium.org>
References: <20211013175742.1197608-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 13 Oct 2021 10:57:38 -0700

> Hi,
> 
> These are a small set of patches that clean up various things that are
> each stand-alone improvements, but they're also needed for the coming
> FGKASLR series[1]. I thought it best to just get these landed instead
> of having them continue to tag along with FGKASLR, especially the
> early malloc() fix, which is a foot-gun waiting to happen. :)

Thanks for picking this! Those really are standalone guys.

> Thanks!
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20210831144114.154-1-alexandr.lobakin@intel.com/
> 
> Kees Cook (2):
>   x86/boot: Allow a "silent" kaslr random byte fetch
>   x86/boot/compressed: Avoid duplicate malloc() implementations
> 
> Kristen Carlson Accardi (2):
>   x86/tools/relocs: Support >64K section headers
>   vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext
> 
>  arch/x86/boot/compressed/kaslr.c  |   4 --
>  arch/x86/boot/compressed/misc.c   |   3 +
>  arch/x86/boot/compressed/misc.h   |   2 +
>  arch/x86/lib/kaslr.c              |  18 ++++--
>  arch/x86/tools/relocs.c           | 103 ++++++++++++++++++++++--------
>  include/asm-generic/vmlinux.lds.h |   3 +-
>  include/linux/decompress/mm.h     |  12 +++-
>  7 files changed, 107 insertions(+), 38 deletions(-)
> 
> -- 
> 2.30.2

Thanks,
Al
