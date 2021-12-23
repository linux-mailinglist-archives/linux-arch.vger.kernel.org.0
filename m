Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59BD47E563
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 16:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348871AbhLWPQR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Dec 2021 10:16:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:44626 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348870AbhLWPQP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Dec 2021 10:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640272575; x=1671808575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ulq2OafBgJ5WWCya4qBGGzVaxV3Xslda9NQaS+urvvE=;
  b=WPgH4hFJlAzgUrogJTYL7hxkMX8lWKtjighH/K6yXRkJ8nPDxpB4gyGi
   JpmXQwe2aaamMJt/P8ha2uq8AwdZR31+38cQLgeuXbOErsDjLdvVeKGYf
   yPqH1vq9mOHAqVB5/4eyraNnhiMBMwL/L/tZ1wQ+tzQjRrLq2hME2Sai3
   EQ3f60jTqKlRogPyO4Q7n5u9dIQKCqg1hOLXfNa2r92w4hEwF4MLELqm1
   tkhpu3BJEXrzE3QXwYA0AYYGfpHF+ukoVnLaN/Z7XcElcHuwBLLR9zTNP
   rz0u6akYe660rRc0LbkLHwXRmHsXx0kJB293L2OYt1ZrERq3lzAdeItVi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="327152536"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="327152536"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 07:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="485119426"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 23 Dec 2021 07:16:05 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BNFG2Jp021426;
        Thu, 23 Dec 2021 15:16:02 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andy Lavr <andy.lavr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        live-patching@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v9 00/15] Function Granular KASLR
Date:   Thu, 23 Dec 2021 16:15:04 +0100
Message-Id: <20211223151504.1409203-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Thu, 23 Dec 2021 01:21:54 +0100

> This is a massive rework and a respin of Kristen Accardi's marvellous
> FG-KASLR series (v5).

[ snip ]

> The series is also available here: [3]

As per request, I've published a version rebased ontop of
linux-next-20211223 here: [4].

During the rebasing, I saw that some ASM code conflicts with, I
guess, Peter's "execute past ret" mitigation.
So I would also like to ask you to give me a branch which I should
pick to base my series on top of. There's a bunch of different x86
branches, like several in peterz-queue, x86/core etc., so I got lost
a little.
The one posted yesterday was based on the mainline 5.16-rc6.

> [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com
> [1] https://lore.kernel.org/kernel-hardening/20211202223214.72888-1-alexandr.lobakin@intel.com
> [2] https://lore.kernel.org/kernel-hardening/20210831144114.154-1-alexandr.lobakin@intel.com
> [3] https://github.com/alobakin/linux/pull/3

[4] https://github.com/alobakin/linux/commits/next-fgkaslr

[ snip ]

Thanks,
Al
