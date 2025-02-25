Return-Path: <linux-arch+bounces-10364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48370A44767
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C7D7A5156
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E6191F60;
	Tue, 25 Feb 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7UDOO39"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752B1922E0;
	Tue, 25 Feb 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502812; cv=none; b=o5p2BbCucyoC0jv+MniVfcXKot1VEBOXRjeXm1Gvk/cIsGx4ebIWFuTyJ9/9kqRVG/KPJ65LXrq+JSFQDbFB5xixzO6frPRUW0le8vsC03Mbifn1ZZSK6Zby48oSzZqDtovgx1RMxefITZISow5TY04khDTL7myZ3Jq6Nc0JsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502812; c=relaxed/simple;
	bh=zGSOvI3eokZTCm8J4P/eTT839Us8R/hog2lZsbFk+hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8sDg1U+DFc+aWp/OLsD/bEmr+h+1fGuIrGai43pC1yoc4or+h5p7JYSCKunQ2VDBXaT0cEFWKwTBw0gV6zrUQFauKrfC5cC0d5+nbSw3f1mjXcfUC5MEkxrTrkDnvMm3ULohWoTYJpOcaNylZBfFqWamE8N2VOxJhKFN7J2DbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7UDOO39; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so9161494a91.1;
        Tue, 25 Feb 2025 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740502810; x=1741107610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGSOvI3eokZTCm8J4P/eTT839Us8R/hog2lZsbFk+hU=;
        b=B7UDOO39sm6KY2KbFodq2tgW4Y9J03JDMgI1iRcB7lDiCVcONCGc2VDYiYyAIsA172
         GHujYXxtQshW/o1RKls9fD8qijzeyb5S+EA8VD3Gi+ABD2RL+m6W84OHbOQWdNqsxj1d
         Xq7R0Cm9SkUCNaifnubZzeL3gfsPeFtnXQ8lOeYNROa/j3u0vbzymEFR+xrBeTZL/DnX
         VZpU0PES12MCA445jdjcJmLMD9EAkWbDhy1FNQlRimTrzVn8uQJQQxZDhvT2iStY2SJc
         L4pQr9G94M1d86h7s6ibvFMnS6zWunCKFPBprObIzfQ4Zp4is4c0FDhwhLdeytMPEPr8
         Y04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502810; x=1741107610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGSOvI3eokZTCm8J4P/eTT839Us8R/hog2lZsbFk+hU=;
        b=cG6OUbbPbqw6zP32mIU5jhSRsMFHyz8wfOtInGV2cuL5LzLV/JHMC0kLVMy4fQJXDB
         V9mSsYC1FW1Wxwm7dcgOcVst5Lk0swphTntsYIgB+OZKOde9H8cHp+/VBmMQAhEojdJD
         ZzrdHZfxnVu97RbiWdjQyfDKZvE4VuWKCavJDCX7g9ULHvEys96uYMj7z+uw31Sa8Bnu
         7J3XNNfo7w1yoQygWGxwn3+0WgTE5MTdv6WHZM8dilX0Q6HIBVHpX58kmshWWwAocfmW
         cw4dlwDERp1lxh+xe48NrHvaYoPPUdxRReCd28djbEGeMwwRhKaAtCQXOfAh9rKlGO0v
         60Hw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Z4RcegwOUORhB26ENUVvMKoc5sfL6eOBp2kfWi0q4MLvbeJJrCNJRp/trInwrMcrIWJk78+5/eFvY/3Y@vger.kernel.org, AJvYcCVxF4rFmnL9469JLQFIcjKZqa0yblqUJDsHBn3lPOOGZcO3G4kguWlHWqUg5OFmY2/a7KucVDooT7wKLg==@vger.kernel.org, AJvYcCWcp1bt869Wl55LdEqJjvU9IkbBL4xpO9dA6LVThpdLcVpS0kILIETblLxSZu5O1zCP//k=@vger.kernel.org, AJvYcCWf0f98lgCWn9Rf8hqUPI+Wq1KIfDiHLJmiciv8ZYBzKn0WeUVDCq16sVhbB5ZZi+IOw+JICAKpyf8+OnKQ@vger.kernel.org, AJvYcCXCtJgG55d6QU2sNwMW5HyH0BmkbnyTnr9z7K6c8HHLerWZHyX/ztYhoVZgPb9MrDnMUHCYWZYGcqsAG2q5rS4j@vger.kernel.org
X-Gm-Message-State: AOJu0YwOdJsx7TyLu8cLtg6jfOJvZu9uPpv3RndVPqUzbvZ+KYQ7SK6E
	xWIXVbgCMe8o9d2/mvPBWiduWI+VJc6bSrjKAExoI4qNaRbRMFrY3H9loZ9rzgWGsWGEHLCWJo5
	lQWn1NULbcClUvotnhvteJ6HpbLM=
X-Gm-Gg: ASbGnctIHi1wHaVEbtMBRqEkICT9PKKGncAHidipL6ScQp84A52in3fpC/BlHAmCtGe
	UZkoM5ABrzwHnt9KfPafqA4tFZfkZdZqJ8sEBCMP+rUk9/xXNkKMuEMbnxAlfogdbGWqs7OJCs0
	YBRQuIWoOLk9gUMg3/NjyKNt8=
X-Google-Smtp-Source: AGHT+IEqGX/0s3L9HOzk4Sz5iomAqtCqwfcqNvGFpgeCqLV+ITRzR2oQPU+QlnRFoROJ8TnyuhJGLs8Sn0eBQ85lycM=
X-Received: by 2002:a17:90b:6c4:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-2fe68ae3f9dmr5490807a91.21.1740502807682; Tue, 25 Feb 2025
 09:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-2-stephen.s.brennan@oracle.com> <CAK7LNAQokoST0FnByeWywaghTMP2aG7hQaV1T=TcQ=1v4ZLQrg@mail.gmail.com>
 <CAEf4Bzb9rYHTVkuxxSuoW=0P84M7UPkBr-4991KiMnFsv10hjA@mail.gmail.com> <87eczm6ckn.fsf@oracle.com>
In-Reply-To: <87eczm6ckn.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 08:59:54 -0800
X-Gm-Features: AWEUYZm71T4KvCmI2nwm6g0nvCi2k88IvtzTenbxtSBKIzvf9AgIN9hu_viY36I
Message-ID: <CAEf4BzZnQmjWLijCZdsNvFTmrAM+ioDW3YygmOZRHqadCg1_rw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kallsyms: output rodata to ".kallsyms_rodata"
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Eduard Zingerman <eddyz87@gmail.com>, linux-arch@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jann Horn <jannh@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Nathan Chancellor <nathan@kernel.org>, 
	linux-debuggers@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 5:24=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> > On Sat, Feb 15, 2025 at 6:21=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> >>
> >> On Fri, Feb 7, 2025 at 10:21=E2=80=AFAM Stephen Brennan
> >> <stephen.s.brennan@oracle.com> wrote:
> >> >
> >> > When vmlinux is linked, the rodata from kallsyms is placed arbitrari=
ly
> >> > within the .rodata section. The linking process is repeated several
> >> > times, since the kallsyms data size changes, which shifts symbols,
> >> > requiring re-generating the data and re-linking.
> >> >
> >> > BTF is generated during the first link only. For variables, BTF incl=
udes
> >> > a BTF_K_DATASEC for each data section that may contain a variable, w=
hich
> >> > includes the variable's name, type, and offset within the data secti=
on.
> >> > Because the size of kallsyms data changes during later links, the
> >> > offsets of variables placed after it in .rodata will change. This me=
ans
> >> > that BTF_K_DATASEC information for those variables becomes inaccurat=
e.
> >> >
> >> > This is not currently a problem, because BTF currently only generate=
s
> >> > variable data for percpu variables. However, the next commit will ad=
d
> >> > support for generating BTF for all global variables, including for t=
he
> >> > .rodata section.
> >> >
> >> > We could re-generate BTF each time vmlinux is linked, but this is qu=
ite
> >> > expensive, and should be avoided at all costs. Further as each chunk=
 of
> >> > data (BTF and kallsyms) are re-generated, there's no guarantee that
> >> > their sizes will converge anyway.
> >> >
> >> > Instead, we can take advantage of the fact that BTF only cares to st=
ore
> >> > the offset of variables from the start of their section. Therefore, =
so
> >> > long as the kallsyms data is stored last in the .rodata section, no
> >> > offsets will be affected. Adjust kallsyms to output to .rodata.kalls=
yms,
> >> > and update the linker script to include this at the end of .rodata.
> >> >
> >> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> >> > ---
> >>
> >> I am fine if this is helpful for BTF.
> >
> > This seems like a useful change all by itself even while the main
> > feature of this patch set is still being developed and reviewed.
> > Should we land just this .kallsyms_rodata change?
>
> I would be happy to see it merged now.
>
> I don't think it would help anything other than BTF, because most other
> things (e.g. kallsyms) refer to symbols via an absolute address. Using
> the section offset seems pretty uncommon.
>
> But it still is a nice cleanup anyway.

I was thinking about possible use cases of some tooling wanting to
access kallsyms data from vmlinux (instead of from /proc/kallsyms).
But, frankly, having a separate section doesn't help all that much
even there. We either way seem to have ELF symbols pointing to
relevant pieces of information, so it's not hard to get it even if
it's part of .rodata. So I guess we don't have to rush landing this
patch separately.

>
> Thanks,
> Stephen

