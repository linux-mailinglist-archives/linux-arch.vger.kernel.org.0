Return-Path: <linux-arch+bounces-8626-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6959B1C6F
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 09:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3DD1F218B1
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A27D34545;
	Sun, 27 Oct 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZrpP4MR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835D33981;
	Sun, 27 Oct 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730016896; cv=none; b=s3Jli1cuGpwfKFJ7tLwzipGdI4uKTUqIuuhsFLT//ONXA+5s4hgKVfMOpjeNmFNkpxDeo7hnTPgGKMErMQ77HsnKkBCuXOljP3ODOPu7aHpbYyeikQA0BEJgwcI0gSWgp/8cct/JZSVjNSg7tXMOJCbSC4QHQHziSV18s5xIXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730016896; c=relaxed/simple;
	bh=qSAev/CmbF0LEyj0tVSWN8qmCbJsiIZdku/WjaNmB8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVJsB/R0lXJ/rP+V8U5WfQNKsqCOllOWF8j83kghw5XyHnXNFVhL7+Li6d6aCkxXXExhd+wnePAP4nRMGfTq8kbY8fRIY8PZhfITwssGuprO6RLUr8B/5wUk2TJemr2+Q/sX8iNTvwSR7X3euH/NKT4pbwH6wQaXIy+BPBOqRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZrpP4MR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A590C4AF09;
	Sun, 27 Oct 2024 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730016895;
	bh=qSAev/CmbF0LEyj0tVSWN8qmCbJsiIZdku/WjaNmB8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MZrpP4MR25ZJQaUjkXbWvdc5yqspOvJPpoP1laWGfu5qW0Bo5w7+sOKkNN0wFTFc6
	 PKiAnBHnQLbmymCc6Ix2g32z3lrMLVbYBDbKHRK7wTcnhc0s7TmExnWPBavGFZA2CU
	 ZxRZ2yQKLbZi954nmodxa3gz2r2765XCY13DTcc/5moZEI1Y5VMl2qOE1/CaCzYfBZ
	 d0xolS/t0CNAWzjdhJc8/vC18yj/tzng9oiNhW1i1/DM5wimZSMibZgTJJr4RQf+Mz
	 txNna8i6XM73z7TsjE2DyvvJtyQZu6VY2mWd8g1ZuHlsQxirw+6OUnQuLNMsd9yjTi
	 Vo6meRtf3emmg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb51f39394so32281361fa.2;
        Sun, 27 Oct 2024 01:14:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKrY2JnajbhOgfOTMZwNUP2moJ7FsjU+bfBh6b0OV9xj94j+nmtVXGSjcIF8vole+YyKvU6Yg5DnY3FQ==@vger.kernel.org, AJvYcCVPBEe9i9XKzmuSrtaR6OrQ0VjNCqW21nuBlS16lF+gzxkbE4Q3655Db3xEslR129H1VPFmVHqauUk5uQ==@vger.kernel.org, AJvYcCViAwilGNYkXVO56bM2EXQJt2+46Y2Z4D9VfazS8au94efnqLeiQGg/Zg1h8U0YoePAz8YbMkZe9g4hyw==@vger.kernel.org, AJvYcCVozSjDwouWcSNxgyhoE/AUtPLyWRqbB5QzM5OninXfjUTFHneD8qfima4JlHXSpf+GMmjSKJoBcRCSnw==@vger.kernel.org, AJvYcCX63oaeAyaoD0MXtEg14BRnJ2OFn7PPEAQo7XnmkN2iSPMmiLL6xzB9KHTAUzWTgbkma1oSOdAM89Chh7pn@vger.kernel.org, AJvYcCXWK1O2eWjQdHIRhozPDAlBWa4thfStccxjlAyZUMQu4v6+zggzQHCtvRVyW2V/XlHNvW62iIdsGtiXpQ==@vger.kernel.org, AJvYcCXtLXZbnmPlCXYGxG5qGr4pM688XPxX2q/dZCVUKcYvtHI27jJMmhmfPEL0jURr7xZAOy4TqLL2KInb@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsFcfOLDY3MYrxjckme8sxNqsiSEr+M3P0WTwTkpl93ensdGn
	Wmybbu98cGeD0g7iDIg8nEYSghWLj4T0ORjZuKGjYEybHqKR8PQfgQaBezv356z8R9yXCVrTy2w
	BXRfMyEPG380XUvoCe9fdvGA0p+U=
X-Google-Smtp-Source: AGHT+IG7GbUAQTdcFb1Y8OjbqKjN3ralEO/b0dHGyoLDxr37yV7KwVs1ozIjCmGYYGFlqbwOihVt3NM/p1aqclI347g=
X-Received: by 2002:a2e:be9a:0:b0:2fb:58c0:de5b with SMTP id
 38308e7fff4ca-2fcbdfb098emr13787941fa.11.1730016893642; Sun, 27 Oct 2024
 01:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025191454.72616-1-ebiggers@kernel.org> <20241025191454.72616-5-ebiggers@kernel.org>
 <CAMj1kXEsq7iJThqZ7WA00ei4m59vpC23wPM+Mrj9W+HXfk-aSg@mail.gmail.com>
 <20241025220239.GB2637569@google.com> <20241026040958.GA34351@sol.localdomain>
In-Reply-To: <20241026040958.GA34351@sol.localdomain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 27 Oct 2024 09:14:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGGDNmPSH4nZH4r6b4UyrPEYBbTZibjXkmxU9c=16_hhw@mail.gmail.com>
Message-ID: <CAMj1kXGGDNmPSH4nZH4r6b4UyrPEYBbTZibjXkmxU9c=16_hhw@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Oct 2024 at 06:10, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Oct 25, 2024 at 10:02:39PM +0000, Eric Biggers wrote:
> > On Fri, Oct 25, 2024 at 10:47:15PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 25 Oct 2024 at 21:15, Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > From: Eric Biggers <ebiggers@google.com>
> > > >
> > > > Instead of registering the crc32-$arch and crc32c-$arch algorithms if
> > > > the arch-specific code was built, only register them when that code was
> > > > built *and* is not falling back to the base implementation at runtime.
> > > >
> > > > This avoids confusing users like btrfs which checks the shash driver
> > > > name to determine whether it is crc32c-generic.
> > > >
> > >
> > > I think we agree that 'generic' specifically means a C implementation
> > > that is identical across all architectures, which is why I updated my
> > > patch to export -arch instead of wrapping the C code in yet another
> > > driver just for the fuzzing tests.
> > >
> > > So why is this a problem? If no optimizations are available at
> > > runtime, crc32-arch and crc32-generic are interchangeable, and so it
> > > shouldn't matter whether you use one or the other.
> > >
> > > You can infer from the driver name whether the C code is being used,
> > > not whether or not the implementation is 'fast', and the btrfs hack is
> > > already broken on arm64.
> > >
> > > > (It would also make sense to change btrfs to test the crc32_optimization
> > > > flags itself, so that it doesn't have to use the weird hack of parsing
> > > > the driver name.  This change still makes sense either way though.)
> > > >
> > >
> > > Indeed. That hack is very dubious and I'd be inclined just to ignore
> > > this. On x86 and arm64, it shouldn't make a difference, given that
> > > crc32-arch will be 'fast' in the vast majority of cases. On other
> > > architectures, btrfs may use the C implementation while assuming it is
> > > something faster, and if anyone actually notices the difference, we
> > > can work with the btrfs devs to do something more sensible here.
> >
> > Yes, we probably could get away without this.  It's never really been
> > appropriate to use the crypto driver names for anything important.  And btrfs
> > probably should just assume CRC32C == fast unconditionally, like what it does
> > with xxHash64, or even do a quick benchmark to measure the actual speed of its
> > hash algorithm (which can also be sha256 or blake2b which can be very fast too).
> >
> > Besides the btrfs case, my concern was there may be advice floating around about
> > checking /proc/crypto to check what optimized code is being used.  Having
> > crc32-$arch potentially be running the generic code would make that misleading.
> > It might make sense to keep it working similar to how it did before.
> >
> > But I do agree that we could probably get away without this.
>
> While testing this patchset I notice that none of the crypto API drivers for
> crc32 or crc32c even need to be loaded on my system anymore, as everything on my
> system that uses those algorithms (such as ext4) just uses the library APIs now.
> That makes the "check /proc/crypto" trick stop working anyway.
>
> I think you're right that we shouldn't bother with patches 3-4, and I'll plan to
> go back to leaving them out in the next version, unless someone yells.
>

Agreed.

If we need to make this distinction, it might be cleaner to use the
static_call API instead, e.g.,

+DECLARE_STATIC_CALL(crc32_le_arch, crc32_le_base);
+
 static inline u32 __pure crc32_le(u32 crc, const u8 *p, size_t len)
 {
        if (IS_ENABLED(CONFIG_CRC32_ARCH))
-               return crc32_le_arch(crc, p, len);
+               return static_call(crc32_le_arch)(crc, p, len);
        return crc32_le_base(crc, p, len);
 }

and use static_call_update() to update the target if the feature is
supported. Then, we could check in the driver whether the static call
points to the default or not:

+static bool have_arch;
+
 static int __init crc32_mod_init(void)
 {
+       have_arch = IS_ENABLED(CONFIG_CRC32_ARCH) &&
+                   static_call_query(crc32_le_arch) != crc32_le_base;
+
        /* register the arch flavor only if it differs from the generic one */
-       return crypto_register_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
+       return crypto_register_shashes(algs, 1 + have_arch);
 }

