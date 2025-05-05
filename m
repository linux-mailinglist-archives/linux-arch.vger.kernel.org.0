Return-Path: <linux-arch+bounces-11850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68AAA98FA
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1509816C153
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A72268C46;
	Mon,  5 May 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZMDKKI6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910325DD07;
	Mon,  5 May 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462742; cv=none; b=dkS0C3cyzaZrYGVb4wadGMkYP0zxjiA1HsbdInR2JiQo1+78ZzW9RnhzYPVzkFbOLp4jncfHY+gB3cok5lKM9hM16AboV9CXn4rNQJMhwgOWte5+XvN584T9jmy2ZKsEB2biZpcVxMVFXHblo+HrEI3ajGnvFyDUtJSG8VE/Uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462742; c=relaxed/simple;
	bh=rHPz6NuSA+qCeZ3wK2DHYpBJr38HhjnJWTXlOhgKBQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cj4rTa+PBnfweAmSH+O6xgTHBkEaVVhGRqUUlo6b2c0bDUhWNCucrohGP6iA8ucvrwi4Sp5cyhxaQlFOhKqgzxQ2Y6JnXBKsfBrQS0pk6OS0wzCaIRCpTndH8OsdhIBepqWcAEUe9X+fx2/86UN4aAkRHgQXG//V4HESv7FGT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZMDKKI6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so5629782f8f.1;
        Mon, 05 May 2025 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746462737; x=1747067537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dr7ugZug3ihf08i6e6l/ueozld66CZifw7NvpZ1p32Q=;
        b=jZMDKKI6I3rRGbDqPEP2SuU9ZZzC3AvStPYBRPxYF8uZZYV0vgJFllIWl6zDIqKxOb
         34SEu1afyizhRTa8S3STclTI8szhUsuh0L4I2dI6od/Ii/0rZqxOPBgnC3be6svocrY2
         ISTHC7GXCtWtFn2L9dSBOfrtvyq7PkihXzcHvJMCoJ+8Ge2HMFKNBXwEA+u0tSJ4GEm7
         Uz0DGwZBZsTqKW4sfUnHXpWw8Dc4RQDo3K4VvvCTMe0y1M0I5ee/hxHWeXBGGMF2srUl
         6CwASX8OlMCDajFhkTdQzKbSbGWUrCmQYPK1Xq1usIhTjsQYqD4BpH4vrm7h4K/oJbqK
         MLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462737; x=1747067537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dr7ugZug3ihf08i6e6l/ueozld66CZifw7NvpZ1p32Q=;
        b=CNauG53SF15KN10qbXiY8Q2iddYgYCghINuzT3qRKgKpYN/MR08j++hnfagyadNISI
         SyhjbCRnGaAEozWUIbOS/3ULdI0U8TMIQZWhs76Yu5UXBBOGIYcRbg9dBkYbakbfFTWf
         DOzVrGCAyRlfRRYCmeUHO//CB2OzDLUwOahfnhW8hfJn0bdIi3lNIiDGTNJfobcMjP5s
         0uxg3XOhLgWATu1V/2mpf+j3MVabKESXm4O6U9/FaX1z15+F7pzImVI3xEpM5LQI7NZl
         BB67Tx8hBIBqgexd+goVd+tNAf+tSOUdcn9Q2dCfthktoyD+dSJpjFi75Ln33mmqCZJ7
         lxnA==
X-Forwarded-Encrypted: i=1; AJvYcCX/PHZ7iOMuxK7BPXS2tmYVdlZzmFF4F6Goa5KtDKLYi58xlxm2qsMFfneqBbFjQRGDEFfRixygHZeUFrS1H+K1@vger.kernel.org, AJvYcCXB+oC4/vE4ymvpvBRNu4daNsZbVIRP3W2nRQ7AvWKhXA40voNQZvmiyGqZZhtB4tUAF36UQBfEfMCI03pW@vger.kernel.org, AJvYcCXFdMnx8zbCuuIJCENtK8zeUa1G31FYgeWsTQtlVag3CURh2JFRmUnq21ljOSI6BtUEF6G602f86z4HTQ==@vger.kernel.org, AJvYcCXkZaedbcRqVv5S86H+gy017vykmBtsGJo07mKcoexmPie1+i5tMFib1kbsU+s9WLmkocs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMvwbNZrpPTIbcndh39bfvMkW2Pvx54fq2oCEfZp2Wp2WW0oc
	i2hhHxz9MW+TEBuGbqZKb922o8i04K9nfQah1XkyGOhQ6kWgOtVxsIbjBUK8p9brKzfyRmygHxm
	zXuml4z10FaKKpT/PAxnSJqNZuZ0ZV5Wf
X-Gm-Gg: ASbGncsKUejic8nAlc6PaYs7clkkQQHXjs3EvbbDy5Sit6BI7AIfSj6IHGo+zY+/YTN
	FvEaoXebddqwcR9ZSgqZv/ywkI2iuFiGFoVJD/0buNZlNidSpTdKGSODvdjQYPElz24oWWXrrYq
	otYtMttSj1rg4L/mopmA1idxNXhkqeEtjB94TyDw==
X-Google-Smtp-Source: AGHT+IHG+22kFekEvDHWpvsN8mD4v3nfTdiuCWcNVqcQklTe7zBeo22V9ljBil0YQj/QiStewPcKfZM6TRliWc+Buds=
X-Received: by 2002:a05:6000:186c:b0:39f:9f:a177 with SMTP id
 ffacd0b85a97d-3a09fd88c00mr5821159f8f.17.1746462737361; Mon, 05 May 2025
 09:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
 <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com> <CAADnVQ+dMwAFPO-ASojjYPxODpCKf_9FCLjUvn2HeHigL53JdQ@mail.gmail.com>
 <CAN+4W8jLdcJbVvQ_YaPVqP0EB6reFgt8S0AZh_w3K80tsJvX5Q@mail.gmail.com>
In-Reply-To: <CAN+4W8jLdcJbVvQ_YaPVqP0EB6reFgt8S0AZh_w3K80tsJvX5Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 May 2025 09:32:06 -0700
X-Gm-Features: ATxdqUHdbOI4X671d2W976joC2FuApB09BT2tB05NhCVoqOpSb3oMxuQtB7YCZY
Message-ID: <CAADnVQ+F0pcP=ohfhE5x+8PZU5y7mKqRvtxBXOQVaKUtuUwGQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] btf: allow mmap of vmlinux btf
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 7:37=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wro=
te:
>
> On Fri, May 2, 2025 at 6:15=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > remap_pfn_range() should be avoided.
> > See big comment in kernel/events/core.c in map_range().
> >
> > The following seems to work:
>
> Thanks, this helped a lot.
>
> > but this part is puzzling:
> >         trailing =3D page_size - (btf_size % page_size) % page_size;
>
> The intention is to calculate how many bytes of trailing zeroes to
> expect while accounting for the case where btf_size % page_size =3D=3D 0.

Well, if it was:
  trailing =3D page_size - (btf_size % page_size);
then it would be clear.

Extra '% page_size' makes it odd.

> I could replace this with a check
>
>     end =3D btf_size + (page_size - 1) / page_size * page_size;

it's equivalent to end =3D btf_size;
'(page_size - 1) / page_size' is always zero.

>     for (i =3D btf_size; i < end; i++) ...
>
> Better?
>
> In the meantime I've looked at allowing mmap of kmods. I'm not sure
> it's worth the effort:
>
> 1. Allocations of btf->data in btf_parse_module() would have to use
> vmalloc_user() so that allocations are page aligned and zeroed
> appropriately. This will be a bit more expensive on systems with large
> pages and / or many small kmod BTFs.

since we kvmemdup(BTF seciton) now anyway, making it vmalloc-ed
isn't a big deal.

> We could only allow mmap of BTF
> >=3D PAGE_SIZE, at additional complexity.

I wouldn't go this route. Too much special casing for user space.
Unless you mean that 'if (btf_size < PAGE_SIZE) dont_vmalloc'
will be the kernel internal decision that is invisible to user space
and libbpf-like libraries would try to mmap first anyway and
always fallback to reading ?

> 2. We need to hold a refcount on struct btf for each mmapped kernel
> module, so that btf->data doesn't get freed. Taking the refcount can
> happen in the sysfs mmap handler, but dropping it is tricky. kernfs /
> sysfs doesn't allow using vm_ops->close (see kernfs_fop_mmap). It
> seems possible to use struct kernfs_ops->release(), but I don't
> understand at all how that deals with multiple mmaps of the same file
> in a single process. Also makes me wonder what happens when a process
> mmaps the kmod BTF, the module is unloaded and then the process
> attempts to access the mmap. My cursory understanding is that this
> would raise a fault, which isn't great at all.

that gets tricky indeed.

>
> If nobody objects / has solutions I'll send a v3 of my original patch
> with reviews addressed but without being able to mmap kmods.

Makes sense to me.
We can always follow up.

