Return-Path: <linux-arch+bounces-3549-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF48A0241
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 23:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6279BB22FFF
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A4C184103;
	Wed, 10 Apr 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KiVwqHtB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EE1836E1
	for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785058; cv=none; b=VXmgp35kfodieYTfTUHbHK6f0vbwLU/GPG9SJWXOLLxYs6A+DrAq4YSws3ZuJfVVvVLK9gXGelGY0vsLjrmdZtxPUWDdBqzg7Uxs53VF/I2bMs/DXF2ooF/q4O9rB0ODHrh//76gGSDsJrOPNbqNWvz92eyYBWPouCjMVwf++UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785058; c=relaxed/simple;
	bh=4GvtKHSmijEdL/CsYuX2Z0N3Y9AqHnP3iFWsMznXnNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErlXdzLrsdIACi1p8JXMoPb5IvyBk3VfAH6wOSC3i9fjWQKRdSupBozZ+1tWcNBCQOZ8+8h3YBtupvWp9rX2kB6YBrj0MxZvsiHstyuXrs2dLJXxmyyO+fD7zzIkTr6ohqmZ4/f5kg3UYXNbS1NiXJFASTE7VMzczXsFT660Wsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KiVwqHtB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-614ec7ee902so73671147b3.2
        for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712785055; x=1713389855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPYtaW73cXDTPjMujaADVZvLP6wj8QcIF+jSWGr8Oms=;
        b=KiVwqHtBFDGaTHxkLwpBJZ8nZtOaAMtftz4m9SplzBL/szgqU2Lg2cMpixSvpMpYte
         rHRYAWiaT6P1SIg+LkCbWptwiHwhSBI7Rn0pmXKQDiawvH70WAxy4E9b/6bUZTgItkPr
         orfuGcRRw1sAwoiTppDx7ppCAUotzO76vVUeEV2chTGX/EtVPKF4km8Thh8lUOLWSGpM
         RwOhhtg6wH/N93iBzX4rpUfjKukCQQT1XY/iH8NwaQqWjP8jPGodmPU1IOLhfUc5g5Nr
         SLleFet3R1LIwzJ/L/d8anCH4SJHal4Y6gYrXoBMlIa5wQ4VnCw2FUecgPONCuD6byMa
         i6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712785055; x=1713389855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPYtaW73cXDTPjMujaADVZvLP6wj8QcIF+jSWGr8Oms=;
        b=cjElrE6p7IIHiasSvPzmhwNqXnlGUwKKjC3rkwLwBZ+RE/Pm1AFglDYyKDv3c6/6RX
         mvHqv52M3nQzKEeyqjD5OEEceYpz8yaWHy6oal5Z47zwLTr+6wQLAKU/k+0sotSKXixz
         KQYcUoNH5lZPAOBuXMXd5HZiXEATisQYRSihN4aVznOkMbuLT1oGMraD/l6mIWCgkogp
         /yMCTkInVylA2SQKQYVuQtwCXghteFs6Rnn+jsVAgu+giE+RtsQArz8z3XRYQcXqLEFZ
         we6XgbkCXxXj65uhdbYJWdytVNg9pemd+MEMQHv5Z3TPwRDTaIGNdxw2A+SxcDJaLVjA
         jtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvzR7XeMv7xdB2bBYi1MUWoq4kAaZ1YOSvKnxEO5GZnDd5Yq+NOiVVphwOjS1LawgtHxWcJWD7Dpt8fUAKON6qFbSgW8giZGIEzw==
X-Gm-Message-State: AOJu0YwvXqTlk9TzUaWIr9iYQSPOKldTZKHSLWdn17som27xHhSV0vJ7
	U7WykAUT0o5Cpz2DEzwlBrlTXLpPjAtDIfIQAW8shi/LJh/e3G/8/lypPWGacA4NUeIFcqjhziP
	iH23vYz7qizVW+XWfEgr6IZbn7bywKJzUK0VCHA==
X-Google-Smtp-Source: AGHT+IF51UvfuZW8F9SKiS3fB7NFequCpltyvy4yxCVwUJis6yJOQ1I5zvJY27CgXu6F/WYzUCxY2XbedDRG3tneEwI=
X-Received: by 2002:a0d:c306:0:b0:615:4700:94c5 with SMTP id
 f6-20020a0dc306000000b00615470094c5mr4293525ywd.22.1712785055129; Wed, 10 Apr
 2024 14:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403234054.2020347-1-debug@rivosinc.com> <20240403234054.2020347-5-debug@rivosinc.com>
 <20240410115806.GA4044117-robh@kernel.org>
In-Reply-To: <20240410115806.GA4044117-robh@kernel.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 10 Apr 2024 14:37:21 -0700
Message-ID: <CAKC1njSsZ6wfvJtXkp4J4J6wXFtU92W9JGca-atKxBy8UvUwRg@mail.gmail.com>
Subject: Re: [PATCH v3 04/29] riscv: zicfilp / zicfiss in dt-bindings (extensions.yaml)
To: Rob Herring <robh@kernel.org>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, broonie@kernel.org, 
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org, 
	ajones@ventanamicro.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, corbet@lwn.net, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org, 
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de, 
	ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org, 
	andy.chiu@sifive.com, jerry.shih@sifive.com, hankuan.chen@sifive.com, 
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com, 
	charlie@rivosinc.com, apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com, 
	willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org, 
	samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org, 
	heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com, 
	cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com, 
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com, 
	mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, david@redhat.com, 
	catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org, 
	shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org, 
	jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 4:58=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Apr 03, 2024 at 04:34:52PM -0700, Deepak Gupta wrote:
> > Make an entry for cfi extensions in extensions.yaml.
> >
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > ---
> >  .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index 63d81dc895e5..45b87ad6cc1c 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -317,6 +317,16 @@ properties:
> >              The standard Zicboz extension for cache-block zeroing as r=
atified
> >              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMO=
s.
> >
> > +        - const: zicfilp
> > +          description:
> > +            The standard Zicfilp extension for enforcing forward edge =
control-flow
> > +            integrity in commit 3a20dc9 of riscv-cfi and is in public =
review.
>
> Does in public review mean the commit sha is going to change?
>

Less likely. Next step after public review is to gather comments from
public review.
If something is really pressing and needs to be addressed, then yes
this will change.
Else this gets ratified as it is.

