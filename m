Return-Path: <linux-arch+bounces-8435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940239ABD91
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 06:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42811284C03
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 04:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321BA13AD05;
	Wed, 23 Oct 2024 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/wLRcYq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027124C7C;
	Wed, 23 Oct 2024 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729659373; cv=none; b=tX76QJdTkEVZd7EhRQFqMQ8/ye1Btac1GYtobAKT6wZTM0tUptmauB55nDVza9+VTnDxUJAUHakIBMHy3BClaLcj+I8OjJIz0VAvAs5/9H1Izbzh+lc3+Z4PqoZ4DC/qQ8ghgHAsg07m1UwWRSAm69Udl3DKKDnSa42Wgl4LrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729659373; c=relaxed/simple;
	bh=AY8Zp2haauObwpX/UvHbw6SC+bgAY17isTJb8nygQ7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxbo4xUkuVFie93RzUBvY2pdBaQQA7eoKMRB65QdVaZOuJE+tZ7+FRcVQIXDs3o0S8AviwrstqzBT0Xh06P7YtG+MAWBzsR9YpMeRKY0ppA63A2nHl81mc8Z2H6eeSGGQFidZDD4l+aYP1Wx4Y7/KD9awwrrQBiakoFRR2DQUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/wLRcYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA15C4CEE5;
	Wed, 23 Oct 2024 04:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729659372;
	bh=AY8Zp2haauObwpX/UvHbw6SC+bgAY17isTJb8nygQ7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B/wLRcYqNvmH9rKOUlk+DslyRamaqLgwQTL6/KJVgEcnszZzVyKKfCyI2AHRJgTp5
	 dOYApRfE9wZH8Kmf+E/2e8ZicbHgYn8OCU3muwWu2w7D6lCaGXSnbiCoYotqdeyirU
	 XbsYTsyJPNNuVpoqs97dqeLr4aTc4CrWHGcMurBP/jtQ67bkS+Dy3jIP7OSC5mCV9z
	 96PAv81sfiwa71YOqspUtVJdezDakaEiM2nAdb/Imas2QlcZwD//sSvlikHLQfAbMd
	 dgD99JcV0OmbXLw2c7yHTyze3fmAJmfrDONepeEouQPw5GCexbS5BMkz4dg/M2Hqyn
	 ajAa+5UHitSMw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e3f35268so4916653e87.3;
        Tue, 22 Oct 2024 21:56:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMLAIFAHs8cWQCbZdOs4uGTQN35Fg6SBHlEgkAGp56yu4T0YetGdhcfgrBbhk5TNDpePsdDV7lvdOC@vger.kernel.org, AJvYcCWehxvkJMgwDe9Sr+vs0fg7Iq0uMnarCFfVu6aK8EZ3Ja9dKEqW4pzceUhCjj9ZMy6NuSadw8BRuApnpN/Grg==@vger.kernel.org, AJvYcCX/f+tkdKB9oxFisSDdYnBC8Lu558K6ybiDV+i6yL0Pt8MwGKi2o/JebeTVrzboEvsDss+21O4Rf16B484I@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLKPRHqSl/hWolUR0lJaGp3YoyRjco5g67qZGGNVlgKTDYAHI
	3cjs2ftBkniO5gZs4b0EP1oh0vFK/NjL4Mgr26WjvMUOv2xBXmxX6TM29gEPrOKZFBtM/8xohTg
	KuIaokcGP7mVXDZ371Sjv28mkHiU=
X-Google-Smtp-Source: AGHT+IH2WKaFs7NPh26+cmobMHBnnTIDPrdXMLtM0gbtf4eQ0HRop6c5o0FiEKJcPuU668AFQL/9XuP68s+wZZoy4VA=
X-Received: by 2002:a05:6512:238f:b0:539:9594:b226 with SMTP id
 2adb3069b0e04-53b1a31f6a1mr440383e87.34.1729659371194; Tue, 22 Oct 2024
 21:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129192644.3359978-1-mcgrof@kernel.org> <ZbrFoKUJQ8MIdzXD@bombadil.infradead.org>
 <ZbvdbdxOKZ9FUQuC@bombadil.infradead.org> <CAK7LNATjKzUVR7DbJqb=yAinJ1YZo8tzwiXA79E9-VrDn11wwg@mail.gmail.com>
 <Zb0zGZrotuWyhsFd@bombadil.infradead.org> <Zxap5hbcXw36rRWW@bombadil.infradead.org>
 <7d0ce4fc-c9ab-4c67-8666-d5bd56dc970d@gmx.de>
In-Reply-To: <7d0ce4fc-c9ab-4c67-8666-d5bd56dc970d@gmx.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 23 Oct 2024 13:55:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASPm8zo2y2vZfeX+LC=xuF+s_bAjkmzTSaT-nmcYoSkKw@mail.gmail.com>
Message-ID: <CAK7LNASPm8zo2y2vZfeX+LC=xuF+s_bAjkmzTSaT-nmcYoSkKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] modules: few of alignment fixes
To: Helge Deller <deller@gmx.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:07=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 10/21/24 21:22, Luis Chamberlain wrote:
> > On Fri, Feb 02, 2024 at 10:23:21AM -0800, Luis Chamberlain wrote:
> >> On Sat, Feb 03, 2024 at 12:20:38AM +0900, Masahiro Yamada wrote:
> >>> On Fri, Feb 2, 2024 at 3:05=E2=80=AFAM Luis Chamberlain <mcgrof@kerne=
l.org> wrote:
> >>>>
> >>>> On Wed, Jan 31, 2024 at 02:11:44PM -0800, Luis Chamberlain wrote:
> >>>>> On Mon, Jan 29, 2024 at 11:26:39AM -0800, Luis Chamberlain wrote:
> >>>>>> Masahiro, if there no issues feel free to take this or I can take =
them in
> >>>>>> too via the modules-next tree. Lemme know!
> >>>>>
> >>>>> I've queued this onto modules-testing to get winder testing [0]
> >>>>
> >>>> I've moved it to modules-next as I've found no issues.
> >>>>
> >>>>    Luis
> >>>
> >>>
> >>> I believe this patch series is wrong.
> >>>
> >>> I thought we agreed that the alignment must be added to
> >>> individual asm code, not to the linker script.
> >>>
> >>> I am surprised that you came back to this.
> >>
> >> I misseed the dialog on the old cover letter, sorry. I've yanked these=
 patches
> >> out. I'd expect a respin from Helge.
> >
> > Just goind down memory lane -- Helge, the work here pending was to move
> > this to the linker script. Were you going to follow up on this?
>
> Masahiro mentions above, that the alignment should be added
> to the individual asm code. This happened in the meantime for parisc, but
> I'm not sure if all platforms get this right.
> So in addition, I still believe that adding the alignment to the linker
> script too is another right thing to do.
>
> Helge

Yes, I believe the proper alignment should be specified in asm code.

--=20
Best Regards
Masahiro Yamada

