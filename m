Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8610E9A
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 23:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEAVhQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 17:37:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAVhP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 17:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mSSNwGMhoyWQ5375GOOf/uQ74wm3NC5DdejM1nUCyb8=; b=MIuqm2d8VU91YVOYxQcFgYL/Y
        EgDLKBirDKGYVS8njJgpYjtO0nte87j6Ureh+xG2CF5T2Ak8YrJbr83WEXXC+C+tTFi8xsnB+Y9c3
        r45yrTeiKPEenIPh4ig1Xr8nS9WWtgeMINKNXgliuECdMmLwjA7kFxRGEHUcMTOLCD5nCgQmzc3o8
        jtrfYtmcawNX95xG97tIjmlWld/5sAZjcOmVNeBzBf7MMo70X6/C5dGhmpRUBL3+YN9uEjqooL0tJ
        tBgUgyclGQsdLK4AlU/9oDbbodCn/5XNg6XvTLtHj3S1ycFFHTl3jvKDc/a5JiC2ReoJZu1F+B4/k
        aQPeDuoWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLwub-0000lV-Nw; Wed, 01 May 2019 21:37:09 +0000
Date:   Wed, 1 May 2019 14:37:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
Message-ID: <20190501213709.GD28500@bombadil.infradead.org>
References: <20190501211217.5039-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501211217.5039-1-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 01, 2019 at 02:12:17PM -0700, Yu-cheng Yu wrote:
> +++ b/fs/Kconfig.binfmt
> @@ -35,6 +35,10 @@ config COMPAT_BINFMT_ELF
>  config ARCH_BINFMT_ELF_STATE
>  	bool
>  
> +config ARCH_USE_GNU_PROPERTY
> +	bool
> +	depends on 64BIT

I don't think this is right.  I think you should get rid of the depends line
and instead select the symbol from each of argh64 and x86 Kconfig files.
