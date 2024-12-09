Return-Path: <linux-arch+bounces-9317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D99E8DA7
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 09:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5CA281509
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F921518F;
	Mon,  9 Dec 2024 08:39:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB212CDAE;
	Mon,  9 Dec 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733590; cv=none; b=AaAG5O49jwXcxz3EJmjbTROjgNHRYTK7tmWJiMAfnCUiGyZGPerFOCdENV7jWu/Noogy8agXVAD/DiNjpKeml8Nqn4j/HV4cR/NIYXHsekilWbOMxmmngU8OGGtUlJRI5YpkdVFZaQs9PdPJJ5GgsaqBoRG6iNBpBIrwaF9BUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733590; c=relaxed/simple;
	bh=Jl8XVHqMZt2C6NUaLrvrkjVEAEzOnkGkd2PgS8L6ovM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzyCFLC0S8J4n3IvtojK5kwwAmAk1nrt0zrK7r4YyQEA3i2dUCnZQQ3cO4w2uE1W7+s3kQs5urXwjB6O6lzw7VNZLqMS/pvUTvSKPiruBLra5iqu4w3nn9pCIa5matXSKADmZ89eVipJjsByeCPYU3yXvK2+XsThRAv8h0NMhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a68480164so545786766b.3;
        Mon, 09 Dec 2024 00:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733733585; x=1734338385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkBZuLv19PU6NMyD5z5lsGrY5nzevthCnCME1a5gWHg=;
        b=HMRiZVoRKVJcnpDra6qF7IANOLkfKknsWyxlvJXudxXtcLkm2/UV/Dt4rkTW4xlYtT
         pGtEryOXcL+0b3JaKYgB+9A4UkLO8D2jGenbFQJ6EySmibJ8lY8rJXQ4+70rOLquAKV5
         vUWRJk3Jsu4Q9cKmK+jyc66uppSDtM9b78qCwLYPi/Ed2Cj34F89reC+MkzrYbX3XAPB
         MQynlNbS9YaTj9z66faO7EE8WffiJFZFF34sebjmyIvxmUAMtm0lgTLckYs4hUYMHfOh
         YxBFZtsYkIyNg2Whb3VtRgDmwhZZBHbjctgqOY4x5f/wJsimXSycVlxuzWls0dG8j37U
         G1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV/KL1MQfdI7r4RW1fj/mM/fj2x1VL01Idb/XJURiXScmvcw3r/Gtjl/X16wo4hYEroKuRw9Rs5YTpAbCGN@vger.kernel.org, AJvYcCVcgP4vZbmbilMwn5jgtBHaid6nPLPtTz5ofRJjGeDYg47eXVBriNnza6AfrhI4fQ5zHoy+1pVqtovlBg4P@vger.kernel.org, AJvYcCXm1+0rWi3gfXSsWf1C1WwI1Qh1c12qnNRyAEYHgCZyZSmMOQ2JUHHb82FAZB/89uOgLKX06Rn/E/dD@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIUI6XjO5lKVPLawQVZ8MBK9sxO7seZRHWKIKb1gsGbYqKv6/
	V6cqc5lVY2J/0xMdWW9SbIki/yXHPvrwnXxTXtyp9dcd9eMFicCoLUE7p182mkg=
X-Gm-Gg: ASbGncspRNzVIUZ2vn4rGgtVCI3Qf/+zzWAhRWu19b0cfELebfjuVYk3Uvs5j+ee7gO
	Chv5Z4IKrWLfLmjFsY6+XPc1sPAVXfwQd7vp5EAy5Hu4b05O2UhJSqa3qJeHN0SU8jr+j53ZAfe
	BV2ucL95jSLn9ZJygxEUUPFOPto1zzK19zSDHPB8kwJ0/YGu2w3nsPyPOSqTxyf8s6rQ0lg69xW
	TvcXj2bdOxzD4/lwwG3m92Ic1B4i/2bpBHprwzwvUrpkwsRKKrLAWhRNuJp3CTyLEe5v8J39qmq
	m/0vZd0ufCwZ
X-Google-Smtp-Source: AGHT+IGUEbVU0BSWlVfqWyxDy6KCsCOKx0H7o7k4EVwuIVlDkCo8ptmatHysFIAIBAb6frQgBvZB9g==
X-Received: by 2002:a17:907:7809:b0:a9a:9df:5580 with SMTP id a640c23a62f3a-aa639fed45cmr1119584866b.19.1733733585031;
        Mon, 09 Dec 2024 00:39:45 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68770c481sm120047266b.110.2024.12.09.00.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:39:44 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso2098123a12.3;
        Mon, 09 Dec 2024 00:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVi80gM9sVJ37J8rLX6LTRM5ioRO5k9UElkgq8ixkwQRym/r/DS7Yeph8rIWg/P5cjTVZ2Aut4TKahl@vger.kernel.org, AJvYcCVrkAfgBlz8+s6L3FQHEmFc3HFimh6HnQ54iWW9AErhTdV1hUZicoq3fbqw2gibgItQljbdoKG/W582fa5n@vger.kernel.org, AJvYcCW5R/3aqdy7JTQab32Q7Pwoa0ei7mNAb1s70D8AoORtth/h7LaeDiyzyRbVam0AtXnHvzVRxGwbAaOmjs4O@vger.kernel.org
X-Received: by 2002:a05:6402:380c:b0:5d0:e3fa:17ca with SMTP id
 4fb4d7f45d1cf-5d3be695187mr11236302a12.15.1733733584470; Mon, 09 Dec 2024
 00:39:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733404444.git.geert+renesas@glider.be> <2c4a75726a976d117055055b68a31c40dcab044e.1733404444.git.geert+renesas@glider.be>
 <b0e9c31f81a368375541d16dbc88783f614ede6d.camel@perches.com> <CAK7LNARwQq-woUeM+a-Eg=Kh3Eu045xL9Y6tbOY0FAM4+Jk4hQ@mail.gmail.com>
In-Reply-To: <CAK7LNARwQq-woUeM+a-Eg=Kh3Eu045xL9Y6tbOY0FAM4+Jk4hQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Dec 2024 09:39:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcXxQUErB6KA2MzaK6v4OO5GEmd9HfES13LE+K4thktg@mail.gmail.com>
Message-ID: <CAMuHMdVcXxQUErB6KA2MzaK6v4OO5GEmd9HfES13LE+K4thktg@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpatch: Update reference to include/asm-<arch>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Joe Perches <joe@perches.com>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yamada-san,

On Sat, Dec 7, 2024 at 3:31=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
> On Fri, Dec 6, 2024 at 1:40=E2=80=AFAM Joe Perches <joe@perches.com> wrot=
e:
> > On Thu, 2024-12-05 at 14:20 +0100, Geert Uytterhoeven wrote:
> > > "include/asm-<arch>" was replaced by "arch/<arch>/include/asm" a long
> > > time ago.
>
> Is this check still needed?
>
> include/asm was a symlink to include/asm-<architecture> in the old days,
> but it no longer exists.
>
> In which case, is this check triggered?

Someone might still try to create a header file under include/asm/.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

