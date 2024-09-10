Return-Path: <linux-arch+bounces-7180-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48694973806
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 14:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60581F262A8
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D636195F22;
	Tue, 10 Sep 2024 12:51:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3501957F9;
	Tue, 10 Sep 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972697; cv=none; b=MHFj8gumLIX83uRgeUtBJk2ryfYPXHsGZoxYUu5kZR8Hg4jye7wKE0L03DYH3uD5SsGchvDmstXSD8hrSjyUTZv6q8OemIgn9BX8aa2crr9kZl2MapA+ub6MmL8y0TL/yJP9mXO0KTKzFHGxOE1nmxldRnmy6p859bUys65TMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972697; c=relaxed/simple;
	bh=682Lk6RmpRTw8VZ2wPqGG287wKzSgc/4y6RyyUphVWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHH1gbg0ztyKvOWohzPIE0BWDUaUQmPc7JcvZDnvBbFs/KIpIFWGXyX5ae9aTt453tw+ETrBvQLZQRjUK0OQysAANjOsaC2sUIpOtpzuIYeL9BiW73bPr4zxL8UsQx3/xYN37cWgBj01xltSg22bOJjuLSGopCLW/Eky6Ydca1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82d07f32eeaso11392539f.2;
        Tue, 10 Sep 2024 05:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725972694; x=1726577494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY/G3MXaavbXgZQIcVqEM6/ihxl9V6XepDsCDLrUSCE=;
        b=kg+SCqQM4YeOxVzjTW5KKE2inr0rsq4q07i1/k1Wvei6bcciDdLyJg1OVDeBWnuSKx
         IeK5giC0FzsmjPV8+NIFQAxWKxKeuA1Bzv7YdroJD8XVc7FY0Mx9o37G67A9cCN00db7
         5ywI/cE3hmw/tNKAL/ltHfklGnDAmWturIh5lQSpaAa1KVF4frclZoULAp2mo6CxREdp
         qhHQG7uhmBDKLPsYQu2dN/7F/NiFF/MKl8DDeXGLAxDiXP/EiuZCXaBQFATpsSHs0+68
         FJOffMnjUQkuqtfAEwvTtvb6Yh+1f0zhFeBb1H8QLdxt61FuYcDSNNpe9YKGhtYKvIxM
         G6AA==
X-Forwarded-Encrypted: i=1; AJvYcCUSkKu+h622fnIhx1VfxsLJuCxqynEfEIYG46kSMs/tB7kcWG/Y7iD1MYu3GkZQ4OVvaxPKxE1YPCbmZw==@vger.kernel.org, AJvYcCUlWczKsrScamFa+uOHfAQTiuc+dbStjDHs9lRrLGFkRmCPREWGDL77vSEQgUI+e/KS0BNl6h2vCZwvzuOj@vger.kernel.org, AJvYcCUuzBpsv5xnyten2rAu4+/5CjhGIg3eRjnkNY2FDB+7uKRnEvoxHCtbCD18Uijy/mw9mUibMIs5a2ZNOQ==@vger.kernel.org, AJvYcCW7AHmJc1VWZbRujHHIiSdt3kocLOp6z3Cpp/F/gpQA5htSkoZJemTpQfgA6p45POCvL44gW4SH8EjB5Q==@vger.kernel.org, AJvYcCWDeN/wmBTQUGKqn0c19BXAbZhBK1GlazjIIZSqZU+pnOEg+L7i+PN3NTe2EQySBHvq2JcXWll5KtA=@vger.kernel.org, AJvYcCWW9OGlZ3f6K+YgIzTIlewL6LKmzO18wucNG075gAfI5+/h9YO7rRUhuB+CrRz/CwRDfr8ilHisWpcVlA==@vger.kernel.org, AJvYcCWsqRmznrywK97ayH63/a6henv2VAyxfjf0wdrR0Ap1+50DgByH8MsnD2j9En7aBCnr/lNWEuYx0AYXMre/@vger.kernel.org, AJvYcCX7QfhbhBEXs85/V22u/UsYcG/tUyvIwTctcovtMH1lJcyLTSY/isqQml4G0mn2Cavo2UfbMD84UdH1IA==@vger.kernel.org, AJvYcCXp5yBUxnNgCo7ukjUPQ9Xjx8Gp1ORz7cMtdRYwVkfrBBcGWY85w+beqp9TcsGBZe9nOkL+IuxTbo3Cl0UZtAqp@vger.kernel.org, AJvYcCXveTBSvYJr
 Xi4urWqBAmu10J2YiMzHMkxotNHDFfktQ8V1sTqhnUdHr+Daw9hfQQ3wk/DRG5Xq9Hccqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQX6Kh6QGqJCgvfycN0AD82jJnJs82d8Q/rVTXxyZufc/V1Ybg
	mYLPL9AHHeIvXAJHh7qe8HoRLzv3lgKnDQyi6Iy/+OPPu97tyh9NsdyE0b2Q
X-Google-Smtp-Source: AGHT+IH2m7C+y8mbmhWtKaiuWKSKlNp6LcOLT4T/R+tq56k2FPXatF/EUshcX4yqiSD8LexgGxF89Q==
X-Received: by 2002:a05:6e02:19cb:b0:3a0:4a91:2263 with SMTP id e9e14a558f8ab-3a04f08baefmr156980465ab.13.1725972694494;
        Tue, 10 Sep 2024 05:51:34 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09464b532sm1605735173.151.2024.09.10.05.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 05:51:34 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39fd6a9acb6so19822875ab.0;
        Tue, 10 Sep 2024 05:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJ44nGf1LFt2ipcuybnlHD1k/ja60qTYfi0Eu42cTSbJT7HEebU5JiPOm5RnDOjJFGccTvmHyiELTtiA==@vger.kernel.org,
 AJvYcCUPGUDNvH/DM1Cj0uvmlQxWc2V9pMEVDje7IaG8mhMk1fb73JrzSlopR+KXgWVrOAseSeUButseAGgUaw==@vger.kernel.org,
 AJvYcCUT0NuuE47oFZm3jdxZEH/tbh2PSNjJ8sTeccXRF3ha4ImE5qhIAxIFt4ZTx2Iq6v4MoNFcFjMZxZvo+w==@vger.kernel.org,
 AJvYcCUYMfYcDV5enph9fqY4IXNuOvaUflW+EkhJ2j4OVvdiX0+UOa1HgxJS9H0w7JuSZ5pYNAl+v44KhTAgtB2/@vger.kernel.org,
 AJvYcCV4kvpVG8lLIUeQw8b8GxSl9WxrPyaoRU2C23N849mWiyq59RackkxPnF9FUKNG762C4wKEH7T3a0oCAw==@vger.kernel.org,
 AJvYcCVaPDv7mZsPBVfzfPItCvDUdnMS2KBUFv8ZQpo75wej3gEK2GwuDxnSWS3If0mrCQD2tA6OzM3twKQ=@vger.kernel.org,
 AJvYcCVwAwFVIMwFZepKRJmKko16M+I3K2IzSKoi29SCzdm1oRvGd6x69Pz1SCRNI3YCUo2tkNCmicpb2uE82g==@vger.kernel.org,
 AJvYcCW7k9cf4tmPw8y6o6PYhneDFdbWD+lthvQZbeBgU2P8a+4XH2pEvZl96yKFKSnLRov42SE1D0pv1nmyYUc9cix/@vger.kernel.org,
 AJvYcCWL2IFAukKKn8Iflv2n8Gda7wrOkJP0yZ/L2hkq+wCItLn49nbHW6y/Xy0HuhT9Oaa9aqKtqjMR8r0P2Uj4@vger.kernel.org,
 AJvYcCWiTqDQDVdQUPxCag5YKfnySzmsBTlhZ9cwwG5N9/d3cGuOsu6rOgyDLyDHMw8NOo0jI3JYsRinZ7hb2A==@vger.kernel.org
X-Received: by 2002:a05:690c:39d:b0:6c8:1e30:513f with SMTP id
 00721157ae682-6db44f37140mr169442817b3.23.1725972199364; Tue, 10 Sep 2024
 05:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <87zfol468z.fsf@mail.lhotse> <Zt9HboH/PmPlRPmH@ghost> <1aca8e4c-1c12-4624-a689-147ff60b75d6@csgroup.eu>
In-Reply-To: <1aca8e4c-1c12-4624-a689-147ff60b75d6@csgroup.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Sep 2024 14:43:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURgy6NPthHhfOv_h=C_gw2hEpnGQ7iBGoDE=ZazUPRHA@mail.gmail.com>
Message-ID: <CAMuHMdURgy6NPthHhfOv_h=C_gw2hEpnGQ7iBGoDE=ZazUPRHA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Arnd Bergmann <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, Chris Torek <chris.torek@gmail.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Tue, Sep 10, 2024 at 11:21=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> >>> diff --git a/include/uapi/linux/personality.h b/include/uapi/linux/pe=
rsonality.h
> >>> index 49796b7756af..cd3b8c154d9b 100644
> >>> --- a/include/uapi/linux/personality.h
> >>> +++ b/include/uapi/linux/personality.h
> >>> @@ -22,6 +22,7 @@ enum {
> >>>     WHOLE_SECONDS =3D         0x2000000,
> >>>     STICKY_TIMEOUTS =3D       0x4000000,
> >>>     ADDR_LIMIT_3GB =3D        0x8000000,
> >>> +   ADDR_LIMIT_47BIT =3D      0x10000000,
> >>>   };
> >>
> >> I wonder if ADDR_LIMIT_128T would be clearer?
> >>
> >
> > I don't follow, what does 128T represent?
>
> 128T is 128 Terabytes, that's the maximum size achievable with a 47BIT
> address, that naming would be more consistant with the ADDR_LIMIT_3GB
> just above that means a 3 Gigabytes limit.

Hence ADDR_LIMIT_128TB?

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

