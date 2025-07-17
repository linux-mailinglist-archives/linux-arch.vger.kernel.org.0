Return-Path: <linux-arch+bounces-12842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20862B09083
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A157BCFF5
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAAF2F8C52;
	Thu, 17 Jul 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaU9i+od"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDC2F85DE;
	Thu, 17 Jul 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765905; cv=none; b=NBEcjnFVlFXWCsqAg6X/Pfag6rJfI6Q8AwFD/tPlgpDmL5XHAfVini4Kq0NlEOywtbsmLIHJ/8P9yQE++1JsUaa5uU5mhF2uZvMSiFtfBSnG1R9aJJ4H66dLeR8Czsj+cJ3ZTqQzR1/tsmf5+DkoTcAYERltEcQhgSv4Zb6EhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765905; c=relaxed/simple;
	bh=mVBl7jkFfQQPKcMZo2FqFRxKgFZixBaqxem8v889rXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkltVxJOI/iNlD6X+M1Fp/F3xWmERidqLgamgheojLLTeY8IO67frOU7x1DSUGKfqkY6EEtHYgiPMY059cDAXfLdbZqV9+D0jEP84IPaz89NEO1i1GMRqrpisqEG1/mTF6BFhAsBlIX/+qPFtBCKbpc8ioIHEny/Yp3aGdEb4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaU9i+od; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a53359dea5so534532f8f.0;
        Thu, 17 Jul 2025 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752765902; x=1753370702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6VckmbMeNSXle4zRhCa92H9M1awVcFui2HysraFMAs=;
        b=QaU9i+odghnAOqAuOb4DIRN4QMZn/wAmcFEisDySwERcc8JFE6cpVJz5D0BsS+FPNk
         9Cf8/UcNxFtdYMm3LdJJqfqYG765q+RtlmcARBkzbffVJbTjiqJuqyyqAB5luLTtGz1j
         YFOuB+Q5CXjcf+WsYo1bWD+puvj9a5+4/HyWNQVba8c4kIHqpMuCC+s+wh9RS7x2HlQ9
         Ap6wSkOFXAa5R4+abUDUtBH/4HK2rSWRmDaPbcCpTuerwGvtkpKnRUUaU/BB6+6+p0xN
         QoJ4Rv/jPHU1Jb1SJFkXlU1SHgD1yd4pWJ74Y7wERiVofyWWlGXkvhREc6zUz8D1eCP6
         hBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765902; x=1753370702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6VckmbMeNSXle4zRhCa92H9M1awVcFui2HysraFMAs=;
        b=nzi+bYt4bpVJHAYUAhGvLY1UgmZvqjJB4tTdtOhQieBunEpoPG6EQV2oaRWgVPyzp4
         hqaQXVxI7bixTWF4A4yQiMp4T3sXIWtL1g0bgSsqX4SXM5mIbs5H3ej2Jdo3pY5ZK91w
         FBp3P1DO5Tnzp2UrX1kcPWnJuK/WoTLPLVYqom2YfiKBiRl24QqUiDhxE1kUPeaGUj/o
         Dmnu8RKQ+zX+iabwPzIB9K0hf19IhMGsiOa4G4keDIZnDcf6Y1u8WfWMoWqHzKCSC2+8
         lfoo5NLInjJzQlVxkqHaeykw3on/xY6Fb/+NWvHOfhSWeA1ja8Qe6rGzAuLT0zwDj+Kr
         0tww==
X-Forwarded-Encrypted: i=1; AJvYcCV0dJ/AHXN3s8cp90ctkz5dE15WA6GkfmIKvAPl/i7h0QPAlZwQ5EejC2kJqYgwCeJ/L9qcKZ66y8UkSEL/@vger.kernel.org, AJvYcCVTYXXKetH5uHv37g3jZbLICuRVPtFLK3NIkPuv1dbT4pidQErlH6IWbmnJuUtnkvxh9toZkz1M7byXKdBtDJS2@vger.kernel.org, AJvYcCWxOVsk/kvhMVYloy8b9HdP876TBv4DnQiw14uwzJgIlX6Dp6mdfP373+BlimLE77FaarZond5QTm2nQw==@vger.kernel.org, AJvYcCXUqqXfMDpApGPkjnua+3WwYtE/dn03ea7GFVcihN6dBmI6i91VFnTcgHwoAQuvFPkjV9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+m5jyxZFvFK5jUsPaM9UaS7B402F6qrrfG1A3jJUfYhIdtS9
	G/dwrHUW+5s2lA7qBaIcuRFLmgmvuKbOrF5odx4qOjihaOQF+Ka0fWmBFlys5YwF1amXrMp0sNH
	1oP8eOzo5XCTm0qHssh8dcd7u5bPCyHs=
X-Gm-Gg: ASbGncuV9+I1OyimxIdy44kbfhNYIdS2GbvbYsHrIWakYjHNGwCMjh+dQZqz+j3ka16
	KChMl2yeY5VIwFuaKNU0JFsjrYNdy8YLtw+QEqtWE38qFNZV0Ipb/31KpdEMmrjY1nAgrZiOMhT
	QgqnpgFrf6donRBlVcCyXMhLw/yR8ackgvZfJ2pQUYQ0hYNce6C8SKdtNK5rBkduH7Uv5hQVJYR
	9eRV2abWLuXQJe1SINfrDQ=
X-Google-Smtp-Source: AGHT+IGeW++fImtoeS2B0SWaaDzKCqDG3PBDTK7fijr/paFUbpQ9Q2BBphVZE3USeT269JcqVLR3X4fwk0ujRPHOEEo=
X-Received: by 2002:a05:6000:144b:b0:3b5:dfc2:f0ca with SMTP id
 ffacd0b85a97d-3b60e53ea17mr6047409f8f.40.1752765901784; Thu, 17 Jul 2025
 08:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
 <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com>
 <CAADnVQ+WZsaDS-Vuc9AN7P3=xvX8TG=rY65A8wYdOARLtkt6Mw@mail.gmail.com> <CAN+4W8i+PqYDcJjWk+g63W4kdKvhFKSad61q-T=JJky5m7j79w@mail.gmail.com>
In-Reply-To: <CAN+4W8i+PqYDcJjWk+g63W4kdKvhFKSad61q-T=JJky5m7j79w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 08:24:48 -0700
X-Gm-Features: Ac12FXww1JBCS6XraoQajcOSXv0y_LFuMb7d0LFifqkes7LZtbikQbv87_xdbD8
Message-ID: <CAADnVQLJTmjt8nE-xoPhE=6Q+bDOWTTwQ9OqQjX+YKT5RPBNrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:15=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Thu, Jul 17, 2025 at 3:49=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>
> > __pa_symbol() should work for start_BTF, but would be good
> > to double check with Ard that the rest stays linear.
>
> Alexei,
>
> This code in the arm64 setup does make me think we'll be OK.
>
> kernel_code.start   =3D __pa_symbol(_stext);
> kernel_code.end     =3D __pa_symbol(__init_begin - 1);
> kernel_data.start   =3D __pa_symbol(_sdata);
> kernel_data.end     =3D __pa_symbol(_end - 1);
>
> Using these as start and end only makes sense to me if the addresses
> are linear? See
> https://elixir.bootlin.com/linux/v6.15.6/source/arch/arm64/kernel/setup.c=
#L217

Thanks for checking. lgtm.

