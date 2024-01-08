Return-Path: <linux-arch+bounces-1300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6AE827699
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB352846F5
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB3955C33;
	Mon,  8 Jan 2024 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGC+SAEU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0555C02;
	Mon,  8 Jan 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e84fded7so7723015ad.1;
        Mon, 08 Jan 2024 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704735932; x=1705340732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fnFo2qN+5N3CH8AeJVVQXPbhYY1VYUCGrkTW1+0CJY=;
        b=TGC+SAEUrnpQGEsTPozidqBIFoQoQ4Vz4kJQHVsRr9hIZXm+szMq5c3e9py4mwunlI
         dnzPA32ENWPK5EIccoeiY4NDedrrIfm6fifpmw8MM/7STRvtEAFhE8VzvJfDbQDDMYrK
         IRXi+xtwLuBal1PKBdAdbJad+gf7zMeOMdz/CBJ7DnAMx3pTWG7ctOoVZpvn3bZcxxvZ
         bdGQIxgBRDB8S/wizLWZfx/A8hd7+g+V05JlSmI3aF5wzvCxm4MPUkj13wEoagCRmYT3
         ayk4GeCZPA2/hRja2KWm//RAGvkMIY6XgJ3esLaRD5JwzAofDTU1ugdgL7Veowr5b9hS
         CS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704735932; x=1705340732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fnFo2qN+5N3CH8AeJVVQXPbhYY1VYUCGrkTW1+0CJY=;
        b=b4indeII1iw/nSnCgLGLsBPHagtTmS9UlVkhtgPNNUwh5v3yAP5HprG1Z20Zo5yni4
         Q/9guW1Sm9nHKIRo388lQ6+G3L38adVBr6DlaAUMtCujMf5jd1FOhIHKw2WL0Mtr/bmG
         CGRDQ7982zS5qj1OcOaaTM9gvzQQtHWxmTR5fYANTT/i6oaxyE9Xp3+k9zmCcfsOHy+c
         KjHpj1TuK2Ak4BBLSVSwgkcoZ8HZb63HV3vDCBuUqiVyoq5JsP4oxtwtVOAu8+hpLY6K
         XKeirgWOy1sTBphP6EZD7LURYoZ/l3xsMoX31c9hBdkOvBTqvw/PWqoHcO2HFCFBq/ps
         ywSQ==
X-Gm-Message-State: AOJu0YxE/l/5KVL4cz2NAH6Y1sdX5gmUtnXwCNXsxU5mEktjXNv0yPKT
	CDyWX/iZslIiM7zUwEAToxc=
X-Google-Smtp-Source: AGHT+IEIdJM9jpfa3YiU9CGymjMNZiakByYFZyndLpbw0yHpCpOH8AJkZoPc48IlAjYuuFTm0gMyxQ==
X-Received: by 2002:a17:902:ac90:b0:1d4:752d:2f0e with SMTP id h16-20020a170902ac9000b001d4752d2f0emr1725219plr.79.1704735931543;
        Mon, 08 Jan 2024 09:45:31 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7a4a:2478:1813:e8c2])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902bd8100b001d06b63bb98sm176997pls.71.2024.01.08.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:45:31 -0800 (PST)
Date: Mon, 8 Jan 2024 09:45:28 -0800
From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] asm-generic: make sparse happy with odd-sized
 put_unaligned_*()
Message-ID: <ZZw0uFeUAUnosaK-@google.com>
References: <ZZuTTRCUFqWzA1y-@google.com>
 <12d88da48f6947ab86a845e8d02319ff@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d88da48f6947ab86a845e8d02319ff@AcuMS.aculab.com>

On Mon, Jan 08, 2024 at 11:03:22AM +0000, David Laight wrote:
> From: Dmitry Torokhov
> > Sent: 08 January 2024 06:17
> > 
> > __put_unaligned_be24() and friends use implicit casts to convert
> > larger-sized data to bytes, which trips sparse truncation warnings when
> > the argument is a constant:
> > 
> >   CC [M]  drivers/input/touchscreen/hynitron_cstxxx.o
> >   CHECK   drivers/input/touchscreen/hynitron_cstxxx.c
> > drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through
> > arch/x86/include/generated/asm/unaligned.h):
> > ./include/asm-generic/unaligned.h:119:16: warning: cast truncates bits from constant value (aa01a0
> > becomes a0)
> > ./include/asm-generic/unaligned.h:120:20: warning: cast truncates bits from constant value (aa01
> > becomes 1)
> > ./include/asm-generic/unaligned.h:119:16: warning: cast truncates bits from constant value (ab00d0
> > becomes d0)
> > ./include/asm-generic/unaligned.h:120:20: warning: cast truncates bits from constant value (ab00
> > becomes 0)
> > 
> > To avoid this let's mask off upper bits explicitly, the resulting code
> > should be exactly the same, but it will keep sparse happy.
> 
> Maybe someone should fix sparse?

I proposed doing this in
https://lore.kernel.org/oe-kbuild-all/ZZnzd3s2L-ZwGOlz@google.com/ but
the idea was not welcome.

> I have seen a compiler generate two explicit masks with 0xff
> followed by a byte write for:
> 	*p = (char)(x & 0xff);
> but I expect modern gcc is ok.
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202401070147.gqwVulOn-lkp@intel.com/
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  include/asm-generic/unaligned.h | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
> > index 699650f81970..a84c64e5f11e 100644
> > --- a/include/asm-generic/unaligned.h
> > +++ b/include/asm-generic/unaligned.h
> > @@ -104,9 +104,9 @@ static inline u32 get_unaligned_le24(const void *p)
> > 
> >  static inline void __put_unaligned_be24(const u32 val, u8 *p)
> >  {
> > -	*p++ = val >> 16;
> > -	*p++ = val >> 8;
> > -	*p++ = val;
> > +	*p++ = (val >> 16) & 0xff;
> > +	*p++ = (val >> 8) & 0xff;
> > +	*p++ = val & 0xff;
> >  }
> 
> What happens if you implement the as (eg):
> 	*p = val >> 16;
> 	put_unaligned_be16(p + 1, val);
> I think that should generate better code.
> And it may stop sparse bleating.

This is rarely in a hot path (typically you do this with a "slow"
device), and while being faster it looks more complex. But if that's
what people prefer...

Thanks.

-- 
Dmitry

