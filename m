Return-Path: <linux-arch+bounces-4638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F88D6664
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC0F1C2308E
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AD8158848;
	Fri, 31 May 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRcdQtbr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1B54784;
	Fri, 31 May 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171760; cv=none; b=c3UGmCCQxcsG8OwQFY054S5ZNVcGTXWYP1HX6mJAGEB/edEQVdakD6DrC/KSb5KwT6f4SPrLDWba0M32bgH1llFi9Djadd3+qEbxhgesZvAn7fans2dH6I+0iP6C+ZLJsF5Ip4MuL/0qfN3+zNu2sKM6OJ2t041z2a9NdVAbTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171760; c=relaxed/simple;
	bh=d/7FCWODhzM+ypJrYan6/6CsLmvkUK1bnC8sfHFlqP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB626VkP7rAIh60c5d3uvG9ubjtVZdBTuK33vrR0Ga+DSXP2fY0pFICHpljGTJ4OcdR3/JO7qO4ZPArdFM6Cnt3iv9l1cdTLH8rw0pi1er9MoDzNWAvknCuWM3R0/6pYeHisUWUVTbHWrPS1rPkD/YKL3woXUR647SDl/+8TozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRcdQtbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F81BC116B1;
	Fri, 31 May 2024 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717171760;
	bh=d/7FCWODhzM+ypJrYan6/6CsLmvkUK1bnC8sfHFlqP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRcdQtbr2eoP3fatVlc7AyK9Cm8+T+o1APLpoigDQNfEQn5A5jQuuuyUfSeMvpN9o
	 nHWoHhQqn1xlzgQqoZsrElY3kYUKSsLwJb2bqIJxFXtfKCtB2oI+mx5umkhAst1eqs
	 ekLnDj0IGjbtlqk8yhU+1qIhuAC5Y0X9pY11UcBMycC2cUbWaiGrFLrCKIFzR0BNCb
	 8FacOKFS/gM7k5nuw9WR5CsNrI4o0DWN54JWEHk0zzLtqo5DHKsKP+RW9mfW35bkHp
	 JFMp5k2jlJAjSwONfASAKp/5nKYM/DmcI7fKZHuxkk67ktbA5epAtDcbe/TZJzvWbJ
	 bCQpkaACooJmg==
Date: Fri, 31 May 2024 09:09:19 -0700
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kbuild: provide reasonable defaults for tool coverage
Message-ID: <202405310908.A5733DF@keescook>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <20240506133544.2861555-2-masahiroy@kernel.org>
 <0e8dee26-41cc-41ae-9493-10cd1a8e3268@app.fastmail.com>
 <CAK7LNAQOdQMi-4ODy69urh7mcfoGrwKt17LBDQLTujxWrj3xjw@mail.gmail.com>
 <e2054e49-c465-46c6-a14d-b48949a738c5@app.fastmail.com>
 <CAK7LNAR4kzwJdf1HtnwK86VuMqpL2CBtpSsVcFH-EGizqLqAFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAR4kzwJdf1HtnwK86VuMqpL2CBtpSsVcFH-EGizqLqAFA@mail.gmail.com>

On Fri, May 31, 2024 at 07:16:30PM +0900, Masahiro Yamada wrote:
> On Fri, May 31, 2024 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, May 31, 2024, at 10:52, Masahiro Yamada wrote:
> > > On Tue, May 28, 2024 at 8:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > >> I don't understand the nature of this warning, but I see
> > >> that your patch ended up dropping -fsanitize=kernel-address
> > >> from the compiler flags because the lib/test_fortify/*.c files
> > >> don't match the $(is-kernel-object) rule. Adding back
> > >> -fsanitize=kernel-address shuts up these warnings.
> > >
> > >
> > > In my understanding, fortify-string is independent of KASAN.
> > >
> > > I do not understand why -fsanitize=kernel-address matters.
> >
> > Right, this is something I've failed to understand as well
> > so far.
> >
> > >> I've applied a local workaround in my randconfig tree
> > >>
> > >> diff --git a/lib/Makefile b/lib/Makefile
> > >> index ddcb76b294b5..d7b8fab64068 100644
> > >> --- a/lib/Makefile
> > >> +++ b/lib/Makefile
> > >> @@ -425,5 +425,7 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
> > >>
> > >>  # Fake dependency to trigger the fortify tests.
> > >>  ifeq ($(CONFIG_FORTIFY_SOURCE),y)
> > >> +ifndef CONFIG_KASAN
> > >>  $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
> > >> +endif
> > >>  endif
> > >>
> > >>
> > >> which I don't think we want upstream. Can you and Kees come
> > >> up with a proper fix instead?
> > >
> > > I set CONFIG_FORTIFY_SOURCE=y and CONFIG_KASAN=y,
> > > but I did not observe such warnings.
> > > Is this arch or compiler-specific?
> > >
> > >
> > > Could you provide me with the steps to reproduce it?
> >
> > This is a randconfig .config file that shows it, but
> > I've seen it in a lot of others:
> > https://pastebin.com/raw/ESVzUeth
> >
> > If this doesn't reproduce it for you, I can try to narrow
> > it down further.
> >
> >      Arnd
> 
> 
> Thanks, I was able to reproduce it.
> 
> The issue happens with CONFIG_KASAN_SW_TAGS.
> 
> I do not see the issue with CONFIG_KASAN_GENERIC.

I'll try to figure this out. I suspect some kind of symbol name changes
are happening? The fortify tests expect to find specifically-named
symbols, so perhaps something is disrupting that?

-- 
Kees Cook

