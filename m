Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C790E4B5033
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 13:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353141AbiBNMbZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 07:31:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbiBNMbY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 07:31:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852549FB8;
        Mon, 14 Feb 2022 04:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644841877; x=1676377877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msYr7lp/NjLWQX8Lr1N6lQehsKDhUEBlDaTRF91PHo0=;
  b=WWicxnF8oUTeZyRc+grWYz7kyQUFReKLOP+L6ghk/Wn5sTO/eE/b+AsU
   3REVQk3/f3hUuJ+o58CoXhUHcQdR8hggraxyf1nCITSRah6B2oZD97C/j
   7Gp77r+is4g6a7H2uRxDlHw8eH/HPsXye/jTbx2wSLuoKpFgya4sIvZ6B
   uTgTp06IpkKKlpWmYVt7XGBB4nTKvz8f50aBp1uMu+fU4riBcBmctZ+9R
   zH2WjAMnTZsr9efWcodjdbBe6ClaAHF/L5QVKnI4F7SCqOZBNCHciwtZZ
   9r+2h2eb8ZjJuK7zPRFDsJbnXv/0mCqBz2sJzl07Z+G1yM1B9oR66dgue
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336505927"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="336505927"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="570153044"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2022 04:31:07 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 21ECV4hY011148;
        Mon, 14 Feb 2022 12:31:04 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 10/15] FG-KASLR: use a scripted approach to handle .text.* sections
Date:   Mon, 14 Feb 2022 13:30:53 +0100
Message-Id: <20220214123053.289169-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YgpEJ7BmuYtHkayT@hirez.programming.kicks-ass.net>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-11-alexandr.lobakin@intel.com> <20220211153706.GW23216@worktop.programming.kicks-ass.net> <20220214113434.5256-1-alexandr.lobakin@intel.com> <YgpEJ7BmuYtHkayT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 14 Feb 2022 12:59:35 +0100

> On Mon, Feb 14, 2022 at 12:34:34PM +0100, Alexander Lobakin wrote:
> 
> > Re "won't do" -- sorry for trying to hijack this thread a bit, but
> > did I miss something? The last comments I've read were that LLVM
> > tools need to change their approach for CFI on x86, and Sami went
> > redo it, but I can't recall any "life-time" nacks.
> 
> Won't as in the lclang-cfi as it exists today. And I've understood that
> this CFI model is a keeper. It is true that Sami has been working on an
> alternative KCFI, but the little I can make of this proposal, it
> still needs serious work. Also see here:
> 
>   https://lkml.kernel.org/r/20220211133803.GV23216@worktop.programming.kicks-ass.net
> 
> Specifically, I object to the existence of any __*cfi_check_fail symbol
> on the grounds that it will bloat the code (and makes thinking about the
> whole speculation angle more painful than it needs to be).

Ah, I see, thanks! I've been tracking your IBT works, but missed
LKML thread for some reason.
I have no problems in dropping the related lines from my patch.

Al
