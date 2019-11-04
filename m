Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E12EDAEB
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 09:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfKDI70 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 03:59:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48792 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfKDI70 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Nov 2019 03:59:26 -0500
Received: from zn.tnic (p200300EC2F0AFA00A5208D92F28E6777.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:fa00:a520:8d92:f28e:6777])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACC701EC090E;
        Mon,  4 Nov 2019 09:59:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572857963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3Gglep10uhUlKdGt/9F9KI4CEHNO3URUde1zRbFYs6c=;
        b=mZ979Q+RwEfYln6X7+2rMbzRQnkLl+SkKWMqTuum8Tfx9zcfxzhHK1nSgWY4G/USMPwuyj
        TAvt+OQ42PFam14XDo4uiLhSRHIQatiruA2gvrK8hu1adymNxCtv2b2SHOWgjrd8YbtKXZ
        N++brJBjeqC7MRe0dmxwetGoUBIRqC8=
Date:   Mon, 4 Nov 2019 09:59:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-parisc@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org
Subject: Re: [PATCH v2 01/29] powerpc: Rename "notes" PT_NOTE to "note"
Message-ID: <20191104085918.GA7862@zn.tnic>
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-2-keescook@chromium.org>
 <20191011082519.GI9749@gate.crashing.org>
 <201910110910.48270FC97@keescook>
 <20191011162552.GK9749@gate.crashing.org>
 <20191015165412.GD596@zn.tnic>
 <201910291414.F29F738B7@keescook>
 <20191030010117.GJ28442@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191030010117.GJ28442@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 08:01:17PM -0500, Segher Boessenkool wrote:
> I am still not convinced the worse name is a better name, no :-)  But if
> you don't want to do the work, and instead prefer the much smaller change,
> that is of course a fine decision.  Thank you!
>
> (I would be happy with such a 30/29 as well, of course.)

Ok, thanks.

I'll start picking up the pile and the renaming patch can then go ontop.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
