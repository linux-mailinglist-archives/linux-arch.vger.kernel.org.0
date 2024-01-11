Return-Path: <linux-arch+bounces-1353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA95F82B59C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 21:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46572864D6
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1056761;
	Thu, 11 Jan 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjw9k24/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548C4CDE9;
	Thu, 11 Jan 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e5521dab6so23923475e9.1;
        Thu, 11 Jan 2024 12:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705003262; x=1705608062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAL60ZiXYTrQWwc6XvTjBF7mU0s/R7MUfIaHS38evWw=;
        b=Yjw9k24/aZTgNRl5he5a0Vg8/Yy0jMdXZhoAoSPnfwwvUeMA4Qn31c1XiLN+UPgtQ1
         WAqFFGlMxMdz6CvMXVfYXdZjGEUbjbODFAZ/3WnesaHK6Qip6LgxG1+n1CEFQoG5UFbR
         Qo7LLWAHQPG+H3feGi+VlGRPq5PHJKsp2OnM/PVDW9My+47hbJbJHPkJZekb8rvIxxOb
         9oFUGl5Yck2WXBPkm+D9OVI/k/zj90X5IrV8oysRtblRZwep3WUf+sIUye8RFv7070XP
         m7yTGU4XXn4jSoac3RZCUdLraX2PgLIxAClGpmm9d4SHIE2KGyZZ7GW9hS36UM1CMBtU
         CVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003262; x=1705608062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAL60ZiXYTrQWwc6XvTjBF7mU0s/R7MUfIaHS38evWw=;
        b=rkKohqDrUywf2Jd0QPkLqApPa7xT6SM4Y+8RZtjHoQsEMbINVfyAEyM+lxuf/glYBP
         MCcXC3lqP6j3TGDYF8r0dGaat+vUZC2/4+yWTOdabmDHfyaBvDxX3HqqNf7dpss8O0df
         WYXL1cueeisGe52zeElZ05TSGHBHOnQ5QgxPY/p+WjjLHiHEb8r/5EwBhqsQMBckyn0o
         lv4pxCbDypMlVyNvH7MkwpMCD0p1QQPkdAGnYx/XG1cSWdC0tvHjGERQLbXMD+UY2Bb1
         fgJGCoei9nFslllazNysPeIIi/tOWxEU9UdXtpTNtxSZTvL+jW/LJ2l1uAsG81v8Y5f7
         RKeQ==
X-Gm-Message-State: AOJu0YwHN1EVUHNOdmfd/DgEwfvWBYKvTWjr+L9yjgzlWTg5cwTXIWLy
	WEhcs3pgJzZ+9h36uWki82ckH2MvBYn192NgLqQ=
X-Google-Smtp-Source: AGHT+IEuD70YW9odmSJBW0ovp3CIEuHoCB7eupgpN0U69zefCCa6AEpsUHBsIEtkfYtc2dUZae2qy6ZzWQ5YfFTTiDA=
X-Received: by 2002:a05:600c:6548:b0:40e:52a7:ac58 with SMTP id
 dn8-20020a05600c654800b0040e52a7ac58mr243439wmb.65.1705003261872; Thu, 11 Jan
 2024 12:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>
 <20240109-update-llvm-links-v1-1-eb09b59db071@kernel.org> <6a655e9f-9878-4292-9d16-f988c4bdfc73@linux.dev>
 <20240111194001.GA3805856@dev-arch.thelio-3990X>
In-Reply-To: <20240111194001.GA3805856@dev-arch.thelio-3990X>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jan 2024 12:00:50 -0800
Message-ID: <CAADnVQKFv2DKE=Um=+kcEzSWYCp9USQT_VpTawzNY6eRaUdu5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests/bpf: Update LLVM Phabricator links
To: Nathan Chancellor <nathan@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	clang-built-linux <llvm@lists.linux.dev>, patches@lists.linux.dev, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-trace-kernel@vger.kernel.org, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, 
	amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>, bridge@lists.linux.dev, 
	Network Development <netdev@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:40=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> Hi Yonghong,
>
> On Wed, Jan 10, 2024 at 08:05:36PM -0800, Yonghong Song wrote:
> >
> > On 1/9/24 2:16 PM, Nathan Chancellor wrote:
> > > reviews.llvm.org was LLVM's Phabricator instances for code review. It
> > > has been abandoned in favor of GitHub pull requests. While the majori=
ty
> > > of links in the kernel sources still work because of the work Fangrui
> > > has done turning the dynamic Phabricator instance into a static archi=
ve,
> > > there are some issues with that work, so preemptively convert all the
> > > links in the kernel sources to point to the commit on GitHub.
> > >
> > > Most of the commits have the corresponding differential review link i=
n
> > > the commit message itself so there should not be any loss of fidelity=
 in
> > > the relevant information.
> > >
> > > Additionally, fix a typo in the xdpwall.c print ("LLMV" -> "LLVM") wh=
ile
> > > in the area.
> > >
> > > Link: https://discourse.llvm.org/t/update-on-github-pull-requests/715=
40/172
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Ack with one nit below.
> >
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> <snip>
>
> > > @@ -304,6 +304,6 @@ from running test_progs will look like:
> > >   .. code-block:: console
> > > -  test_xdpwall:FAIL:Does LLVM have https://reviews.llvm.org/D109073?=
 unexpected error: -4007
> > > +  test_xdpwall:FAIL:Does LLVM have https://github.com/llvm/llvm-proj=
ect/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5? unexpected error: -400=
7
> > > -__ https://reviews.llvm.org/D109073
> > > +__ https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf4=
1d121afa5d031b319d
> >
> > To be consistent with other links, could you add the missing last alnum=
 '5' to the above link?
>
> Thanks a lot for catching this and providing an ack. Andrew, could you
> squash this update into selftests-bpf-update-llvm-phabricator-links.patch=
?

Please send a new patch.
We'd like to take all bpf patches through the bpf tree to avoid conflicts.

