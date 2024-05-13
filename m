Return-Path: <linux-arch+bounces-4387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7668C4A0A
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 01:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602A3B23241
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C0B85938;
	Mon, 13 May 2024 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iwklbf9+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64A85272
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642909; cv=none; b=HwU441xzPmoDkyT88BMrTh93lGbHQJT/C53AeRTo6S+yrGWb28mWMgWRt6qk19iSKvbB9ACu3EkMF0/fgDhOymC38kEPyhibcB3hd3aqZnqi6OnPWS1y30ostihk6B8EU0xoWPVgI7b/YoZ80SIt2zHDbQCNinVefZR7DFzS1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642909; c=relaxed/simple;
	bh=FK/pOlv8p257iH5M65SUDFW31ZwENP3sUAncbWrb2UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+qtaKgwRZTUqKQirRNjRGSA3i+z7OYLzKvyAPrrnOCAM3upSXfRAZYQokdhIhodeh+lfzU4o476sjhxJxFl7dnxMcHSBeZi7XhHV4w/YqwJkPq8mZIrUfErXafwdl1pZosODwb9i+QMYF70hQAGIVULvzhqa85rUQiKI3l7TqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iwklbf9+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b38f2e95aeso4132138a91.0
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715642906; x=1716247706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Alp79KUasntAH1xAOt+qh9t4wrzIhrRSX97PEjrZLDc=;
        b=Iwklbf9+elmKMIJNZC5JlY5Dgm8Sqo6bOGVL2h+cjBGV0hwkHTOwKHWMQ7LrW92oh6
         tX2cKiKifvFY+PnDbBdRlieMj3r2qJvtX035ZGqUfppuwZBfw3dpexgQf0lpdxrOc2xi
         RXXuAOI6iSl+rSmIv//TvYamEErrIk2FtK+ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642906; x=1716247706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Alp79KUasntAH1xAOt+qh9t4wrzIhrRSX97PEjrZLDc=;
        b=he4BB2JjAxwmLp1tAl1CtZ2et793ju3gRFiwHpFNNr7WSuqd6eJwuqyMN34M2ZJAMo
         tWaxaBm/XvbMSHwqvjDD3BTKWckwDZaDuQ3j0qNe6VJvfM0CJwrTQA3n8KH0YNkIXzNH
         YfbdflvjglVDLBuIuvlaFRJCF15HCihm2KH2FpROb8nzDQM8/VWO+zRvsSoj94edaCSZ
         fEuK/sPXN7K6E1j3tDUDakgpTrhMmLQIkPC+WQbYhtle9gAUrIsFqe5eB8IQGF7LdEnv
         8vdoArnpgKDgy6D0tTjkF432sHOEuMpSQgI+f4INHP//kV2umQ53ile9dCxuEJ6QXfpt
         SyJw==
X-Forwarded-Encrypted: i=1; AJvYcCUtAjy96MrRDqWfQKpagMq9pfxZta1gXUfmRYLSd2k8aQdCtE2YDiyNUI0bMuJrUpilW5TyZORM/ekSQFq68OiOKaf/2i+FXmffAw==
X-Gm-Message-State: AOJu0YwAuWQzmXlSbzKbnivA70hRDaeG3d3vyC/yRlCUIE6X0ZWuYzMk
	bCiFxVzNlSYHUXtlqOWKOMm5qEsu7ZFh4cYVNkLTwOO76eeb72sWW1hwWNFOfQ==
X-Google-Smtp-Source: AGHT+IEFgmE7chs18iM9GrKNc3YSJsTec4uS+kF7AHYYIMLhQ7Or1D9QN4CNuHbEiHbakVLBZ9zUHA==
X-Received: by 2002:a17:90a:bf08:b0:2b2:7c65:f050 with SMTP id 98e67ed59e1d1-2b65effb9d4mr20481677a91.0.1715642906269;
        Mon, 13 May 2024 16:28:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863cd9dsm10304270a91.12.2024.05.13.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:28:25 -0700 (PDT)
Date: Mon, 13 May 2024 16:28:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kbuild: remove many tool coverage variables
Message-ID: <202405131626.D61F8228@keescook>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <202405131136.73E766AA8@keescook>
 <CAK7LNARZuqxWyxn2peMCCt0gbsRdWjri=Pd9-HvpK7bcOB-9dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARZuqxWyxn2peMCCt0gbsRdWjri=Pd9-HvpK7bcOB-9dA@mail.gmail.com>

On Tue, May 14, 2024 at 07:39:31AM +0900, Masahiro Yamada wrote:
> On Tue, May 14, 2024 at 3:48 AM Kees Cook <keescook@chromium.org> wrote:
> > I am worried about the use of "guess" and "most", though. :) Before, we
> > had some clear opt-out situations, and now it's more of a side-effect. I
> > think this is okay, but I'd really like to know more about your testing.
> 
> - defconfig for arc, hexagon, loongarch, microblaze, sh, xtensa
> - allmodconfig for the other architectures
> 
> (IIRC, allmodconfig failed for the first case, for reasons unrelated
> to this patch set, so I used defconfig instead.
> I do not remember what errors I observed)
> 
> I checked the diff of .*.cmd files.

Ah-ha, perfect! Thanks. :)

> > Did you find any cases where you found that instrumentation was _removed_
> > where not expected?
> 
> See the commit log of 1/3.

Okay, thanks. I wasn't sure if that was the complete set or just part of
the "most" bit. :)

Thanks! I think this should all be fine. I'm not aware of anything
melting down yet from these changes being in -next, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

