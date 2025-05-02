Return-Path: <linux-arch+bounces-11806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C031AA77E8
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 18:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963C2179544
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A052571D5;
	Fri,  2 May 2025 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Ov+YvTT7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF82550CD
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205169; cv=none; b=fW6882+W2SfIcoL24nTedOwnkxCPxKvi/cTN41yBeozG9pAqH0qHNB46c97dqI9AmvhsQ4EGbLF7ghiNh5zQ1CCKJMCWv7x2cOaC7DXCmgsvnF+fb8SYZKZDX9xKJgWvM+QtT8bTcNkeQXYyzDqsjHAkthLt08ANglA5Kf7geWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205169; c=relaxed/simple;
	bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTb67kDPPl6W1WM71eL0dtM/HCruaALVprqUtUrNBp7893URjS4NhBKgnN81WNvwF3nIwH7v6JYqXb7+Akalr6ZXRTkYsLw5wtk7dbr9w6oHZy+ZjRAiW1lEAI1S7mD4zxHJWRrkoJALGOfoQtX3nzFQi+kmf90kaKn94+DJsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Ov+YvTT7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so410347966b.3
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746205166; x=1746809966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
        b=Ov+YvTT7pZvmfTQ921cZ0uGxQDVxkLfFeo5YbcPwrgQB997dMJdMPobln9IDS+rsTC
         YQjYi/RhbTJS44v9omjItplGkdEFsfVoWx3WrH3X1KxjZ7X+TMyb6iB/XB0Wfet0E0Yl
         pcf88CRz6jnqL8d42BaKNObo+m+3OjEqDJS6atiIz1DxbVcSJd0EOiIoD+LzIQxFRPD1
         x/5QTfapZihghutBY9VRDkdVDWgX1VB/wDH97BFoRm9Tzyrw+FD3mFUq+GlppWyxW2r3
         A9SZpyWvoxOLmYqqDlLl3eAUmvrWPB4OBRLa5FS9sc8IQw7dDYEIHi7PtLgIXL5ec6me
         DB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746205166; x=1746809966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
        b=ITGrZb5CBXT96OKLFiFxGoJjftHbArip1fxwXm4IeEQyMfQQaZUIpj1HeYPoeCsUbq
         j/Ed+MQlwbuE9LOPCJplyi8ubpT4Ihu0j1icfmhqLdMBpe+0dJeuY71LxEW/eydwfjkv
         DQM6nP9VnKY9Ouprz7QAx4TaqJkuAj4/NiUxfY/Y9MX4jmW0ZSOEbiF6lbAnx/deOh4q
         yqbqYsVzp41zQarJ6duR5XlTGksQUomoE8deekztRXrCscH7lULoIeL0DDxEqL+/JWUu
         HD+rMLBObs61K6+3rlvs5iRW/ugmpC5mKD2zCf3lsYOeRb+QE6C65G5sOk1HHl/a2Uou
         72yg==
X-Gm-Message-State: AOJu0Yx1PqNXsFzM9Piq59uz/kAh/bGmGsPM7eNRetlu+Sq4D+Kd/G0c
	q8cWKJAVN5sr28ZBDfMPqPOYxvnK6GA3aqgFQY8aEL9Y8I3h4YW62rDQdK33Y821hs3D3ExyqQk
	JqdUsHJf2jJ9/gPB7yNN3dhfym9KNrdsxu/A8aQyYi98nVIKh
X-Gm-Gg: ASbGnctjKYzCmY6bCHJ97UT5MLoC0fI0FJCm+1FPcvCQcE0fewAhH5vuw/T1OwrkKYG
	6FwS4b0o6Csp4NySnTpAmiEN41KHSM2noyo/pgAwvZh8yf3m1c/ZToqnGQ30r4HnZrfyNcNfar9
	n8ap2dOG+gKPjw9f6tDvA6IhzruLq44MysnqE=
X-Google-Smtp-Source: AGHT+IFtImagR6Lqfgo7XIZ1wWl2+tLkZnQp/pTB1oR1k0UzDInmGHhqpcROEep6B+1QLhfQbASn6A2YAzPAFuoWbdA=
X-Received: by 2002:a05:6000:402b:b0:39c:e0e:b27a with SMTP id
 ffacd0b85a97d-3a099ad70dfmr2371455f8f.23.1746204815370; Fri, 02 May 2025
 09:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com> <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
In-Reply-To: <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 2 May 2025 17:53:24 +0100
X-Gm-Features: ATxdqUEmdXYDqO_tQ1hPoaj8fCjwznGA5fXIlAwLRODgYtT6LMxPzFPPx9AIs8I
Message-ID: <CAN+4W8i0CB+gYcBNyWUxAA+=89Q+nMFopxKUF3nt1+y5ATaNyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] btf: allow mmap of vmlinux btf
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:20=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> User space needs access to kernel BTF for many modern features of BPF.
> Right now each process needs to read the BTF blob either in pieces or
> as a whole. Allow mmaping the sysfs file so that processes can directly
> access the memory allocated for it in the kernel.

I just realised that there is also code which exposes module BTF via
sysfs, which my code currently doesn't handle. I'll send a v3.

