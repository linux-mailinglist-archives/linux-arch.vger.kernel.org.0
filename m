Return-Path: <linux-arch+bounces-1998-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C68847307
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67144288330
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DC145B2F;
	Fri,  2 Feb 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSIRIvs+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B013EFFB;
	Fri,  2 Feb 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887276; cv=none; b=kfyGCcq7rnxedOcB/ax/hFbPOXLY1vQm+SM2ZD9MSZxZopaPGnLb3dHfe8hVrgVcEAB7Wni84mlOdf7Y4qvPY9GY9yop9HZb3l0vRtoz8xmk6v/sVRsLqo713lPtMYjkcIii86OEFRFVHp1/clOTv9JxS7Nr/WDcMi/pk+BI+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887276; c=relaxed/simple;
	bh=0yNhjRjjBrPSYkEE75fe6day5rjDcDN1mHZuJt/lews=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF/sC/HuYG8Kf0BrnUzoTvQxYBxhJknoLeLCLMTbJ5DRKFtPL+GnfnZKLVNj4dHMsGQy67fYEESpq8GlaBdfdKN4hbpJRy+blyywcYtAAFoItQCYKzDm2MnJpkcNe+awxRIRJBvtKQPbls04hOM8NGVmU3zT78gtTejJCrdHQ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSIRIvs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06796C43390;
	Fri,  2 Feb 2024 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706887276;
	bh=0yNhjRjjBrPSYkEE75fe6day5rjDcDN1mHZuJt/lews=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dSIRIvs+4wdA9Qb4/7v7sD8tdZGV0n6oxoLE2/RTUoHkm0iJ6caDBcZzqdH81G1U3
	 75k/pfM8KEeGqsAWhKgs6j92lHwtLthmfnTSHXtTFcSsdm+uiXseREZsG5iapXYyHJ
	 YV1gHclPggUr7LSud8Tqr1bPUX+qh0+eBzsdEw7eq+FTtCpP9cowbs8qdmB0FgOoPu
	 sBdQn8IKCJlTpdUoMF6VRACrFhnkDj5Dv176GRdDCIKwvqje9x+STwpe+BjZM7XCAf
	 OxQ40t9B8jSARVk4+Vgug21pG4c5ZQkLqm/xMCm2hFQPHL7EdrBI47o5EB+HknWv3l
	 BoWmZyCRklTKA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d070e2ba0bso22860751fa.1;
        Fri, 02 Feb 2024 07:21:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyPjV1boNhQNmZAUbJUgd/8l4izNAGrU8MdXYW5TbcqUkLDu5+2
	bZxAgPX5NVyax9Q+vPQlDJSnDAxaqWNxVaFSA0l/QqNJheEP2T79L2huWw4AO7NnNTmEVDSaTQu
	QQqPuM1sCzBmIKGsus8X8q8LC9kE=
X-Google-Smtp-Source: AGHT+IFTD6sDSKot6jHpqFbFtvWhvQ/uN/A1XNsAHhkuL0pWWgFr7u5/XFWoSG++5ez6Sy/OUYUnjK7k4dMycXdIVus=
X-Received: by 2002:a2e:7405:0:b0:2cd:2771:a2fb with SMTP id
 p5-20020a2e7405000000b002cd2771a2fbmr772203ljc.2.1706887274531; Fri, 02 Feb
 2024 07:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129192644.3359978-1-mcgrof@kernel.org> <ZbrFoKUJQ8MIdzXD@bombadil.infradead.org>
 <ZbvdbdxOKZ9FUQuC@bombadil.infradead.org>
In-Reply-To: <ZbvdbdxOKZ9FUQuC@bombadil.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 3 Feb 2024 00:20:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjKzUVR7DbJqb=yAinJ1YZo8tzwiXA79E9-VrDn11wwg@mail.gmail.com>
Message-ID: <CAK7LNATjKzUVR7DbJqb=yAinJ1YZo8tzwiXA79E9-VrDn11wwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] modules: few of alignment fixes
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: deller@gmx.de, arnd@arndb.de, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:05=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Wed, Jan 31, 2024 at 02:11:44PM -0800, Luis Chamberlain wrote:
> > On Mon, Jan 29, 2024 at 11:26:39AM -0800, Luis Chamberlain wrote:
> > > Masahiro, if there no issues feel free to take this or I can take the=
m in
> > > too via the modules-next tree. Lemme know!
> >
> > I've queued this onto modules-testing to get winder testing [0]
>
> I've moved it to modules-next as I've found no issues.
>
>   Luis


I believe this patch series is wrong.



I thought we agreed that the alignment must be added to
individual asm code, not to the linker script.

I am surprised that you came back to this.







--
Best Regards
Masahiro Yamada

