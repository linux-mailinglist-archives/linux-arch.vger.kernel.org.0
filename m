Return-Path: <linux-arch+bounces-11203-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47395A78307
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 22:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE3E3A73CC
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834B6202C51;
	Tue,  1 Apr 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj0UIMgJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC717C211;
	Tue,  1 Apr 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743537660; cv=none; b=cJxvxjfqgGpKoRl3sO+NzDIEonM/J0I2Fu44Uu9iF0V334M07S6wtqfds4TCxq8BqlRZCyoIFqyKhc/rf+eUkgqDpP8fj34CCLCxunndADIiVjPaFUEcyAJuBI2hxpxspRl+dXlOVm5FDuRLo9Qx0L5rXBglo0BU3YHk9B80BKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743537660; c=relaxed/simple;
	bh=SsEtymDjFxM1dLd88DEPk7b/DPbXgQcSJ+nDYJthskA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y78rRU+QtdRyCDqIaLlBhyfPGUrq9lZvlIdcgtPJM+04/fzsjcJiNcs74qJ+vTDZXBSYDUmft1u//CgRRzmK43wWMu80Md5b82+Mecb4uu84xmF6Cl8X8uA+ueJzPVhU5bQdbCsvim/a9abbfGMPYysq1/s6h3whZt/byuEeFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj0UIMgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB7BC4CEE4;
	Tue,  1 Apr 2025 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743537659;
	bh=SsEtymDjFxM1dLd88DEPk7b/DPbXgQcSJ+nDYJthskA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sj0UIMgJB3BhWg6Q5hThirUmVNapBvLUCssaM9xJhq4z8rINztn8U2a8VU7uKVvO+
	 KNTKB8yFVEH/6P0aJxnzC8ql/cEZBktK2XjcFkIJonPY+vNiktGaEJh1pu3KP86pOZ
	 0Z/JDChHvvi4fQgWwY2pv315OrvtUWanr7oVb/zq3/xkPyam7hR1FljADmz/mdjKmW
	 3KeD4+Bq0JfzX1PdRiolOCzdjflmaIQN6ONyog6XNtxrNEObEDL4X29f59mJiYMhry
	 cfSVpBrf0Tf8VE+sJ34qXMxAOHcRzpXoXlXhcPxZlM+YajKX9z4ArQ7bi8GhCQGACf
	 ReX1Z2plvjm5Q==
Date: Tue, 1 Apr 2025 13:00:55 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Alessandro Carminati <acarmina@redhat.com>, linux-kselftest@vger.kernel.org, 
	David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Kees Cook <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>, 
	David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Maxime Ripard <mripard@kernel.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>, 
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, loongarch@lists.linux.dev, 
	x86@kernel.org, Linux Kernel Functional Testing <lkft@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 06/14] x86: Add support for suppressing warning
 backtraces
Message-ID: <rkuxvq6pkha6pixz5rtu327ujt7ism5f4wgrak7egcecuxwe42@qkn5ewdzwhvo>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-7-acarmina@redhat.com>
 <20250401170829.GO5880@noisy.programming.kicks-ass.net>
 <ddc7939f-fb98-43af-aed1-0bc0594ecc41@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddc7939f-fb98-43af-aed1-0bc0594ecc41@roeck-us.net>

On Tue, Apr 01, 2025 at 10:53:46AM -0700, Guenter Roeck wrote:
> On 4/1/25 10:08, Peter Zijlstra wrote:
> > > +	if (!KUNIT_IS_SUPPRESSED_WARNING(__func__))			\
> > > +		_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
> > >   	instrumentation_end();					\
> > >   } while (0)
> > 
> > NAK, this grows the BUG site for now appreciable reason.
> 
> Only if CONFIG_KUNIT_SUPPRESS_BACKTRACE is enabled. Why does that
> warrant a NACK ?

I agree with Peter, this bloats the code around thousands of UD2 sites.

It would be much better to do the checking after the exception.  In fact
it looks like you're already doing that in report_bug()?

	if (warning && KUNIT_IS_SUPPRESSED_WARNING(function))
		return BUG_TRAP_TYPE_WARN;

Why check it twice?

-- 
Josh

