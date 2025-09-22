Return-Path: <linux-arch+bounces-13715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A29B91B88
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 16:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9241744BB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D323E25B;
	Mon, 22 Sep 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="T5tm19TQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB812236FD
	for <linux-arch@vger.kernel.org>; Mon, 22 Sep 2025 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551351; cv=none; b=ged5lOshiMYI/GTutxwjnWRQjCHxUPpNDl10cxT7YPelBzFELAC270RUEPXv3rjqi0fNUVGDdQl5gvsjpFRTPJQGyNKXqwbWqGvAos4Qs0o0STHq2ezsc2PlRCG1FItoeDwjbC4/N64RqxgAh/d1MndKtHp+hiqu1/5WCEoNY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551351; c=relaxed/simple;
	bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdX7rbLzNZUYZVkNiKvbh7EIMQ2Ae1/+NqHc28lzmTEViFXEGrErJOHzyKMflki4kqkZ/2C/tIdqgUktsmMrSHDXmimI9wN3xFnMBa7zz+9EeSiqr/3HO0b5kReBUcIJM0nzGqI9YKHBTS2frk54CyR59znzGUuJgh+tH5V4eDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=T5tm19TQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so3950510e87.0
        for <linux-arch@vger.kernel.org>; Mon, 22 Sep 2025 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758551345; x=1759156145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
        b=T5tm19TQZikqjHqoMR54+Q7+U/JgAbrwxCDjAEr+j4BV3oKJ1vYACVblsq/0dgQB3O
         xzcE44eyHkSt3+1/LwS8iG05NDQybwpGXmErJGsX7qf1JoHnxQE/QJKsAyQCq5BZ8yUL
         fZfsv/oGGtZ7K0RaFe8fFXZtm3jS4C5jkLwGskUTTKy01oseY4elZgmJ1wcia/Nwx29N
         /akdQTqyJ1yRSFcBAOKV1BSGnn1RLnJEPHIfsiagl3HTh7OEmakPzgo3DZkunVSmL2Xx
         hH2z75SXfyBjFg0mXpIzvJjI6rXfLJCfOxCsk/r78caU8Q500JO1XsPO5Zy2dD22Jb+z
         2rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551345; x=1759156145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
        b=E71I1fi5yGa7ZJlF1Aj8434q/JCad3so1uLY7k9k5SsNhAm/ETva+Q4wI+C98xtGnJ
         jkwEiWyQ7F54KiYtmoH7LDDUuGAX8X8GWLIV4JzICMPCj+9m6g7t+fjGswBXmQDykMOw
         cpQoQXV6+H7bTjUH59pKq4rH24RuZfc7MQegAWsX7APWJwKNn2DTG+u8ll59IM7kui3n
         uz2zxmShazUHXJ2wQrRkSdgh9kgWPH/OO0EJfIwdpQPaDuG6g94b/yzInUBTae6B+S71
         a/LZO7ViZxkmTJE2GNN2FgphXz6pRpoSHyf2UOJjn10k30mF075FPr4kkcqJO6mLRBaV
         nUwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYbnKxOmxu6jo7lvXTotcfSoSTAj4nPkq/mINGk3xeLkTCN/RSk198rFowc5mg6TcvfkI2pZRA6QHR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxopv14NIhgQU3e36g/Y/i/jGlwiq7lmToIB15+z9dH3TlT7FxK
	y9QnyUuTsGgdi0wJ754baJQUS9kW4Fyq8jLo3wIjvtAvlJmZVd+p8ydBt92fDdHMIY419ZyWNR3
	6McxkrPTSi88FglJxyO35xj+6QEe2A/ote3zl0IvjWQ==
X-Gm-Gg: ASbGncu1BnA81W3RSC5NVuk08TR4XJkZAnqPwtohIjbhaE+YMvq+uIrCz+4nJgclxSg
	7eI4qV0j6XGLpyaC8XHZ2Be4iare5BjA76q0Fu9pOiZ5IJg6ejPFROAqtLAZv8yBh2JepB8A3Zj
	WX9Hl8tyVSs2kmPkgSIghTb40z7DMewdQyOkAL2HouIBU1cz5QvqZP14sl2GkZi9GG+N0MwqYii
	hAQV5XOww/J8hI=
X-Google-Smtp-Source: AGHT+IF9Kx0YHTgWZximr8IphichwJGTQ/wmiFKfxBKU7xEPIwY53K1eZ5EsUZqb+vcW1xAllqgOcQU2VEEacURTmEE=
X-Received: by 2002:a05:6512:4389:b0:57b:478b:d8a6 with SMTP id
 2adb3069b0e04-57b478be162mr3313173e87.35.1758551344116; Mon, 22 Sep 2025
 07:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com> <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
In-Reply-To: <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
From: Nicolas Schichan <nschichan@freebox.fr>
Date: Mon, 22 Sep 2025 16:28:52 +0200
X-Gm-Features: AS18NWBjmNA3KBj8cPrgwDAVm5OX9a5odWP7LbRlHvhoE96nP3yo2_PGoZ1JbG8
Message-ID: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending to the lists and Cc, sorry I initially replied only to Askar]

On Sat, Sep 20, 2025 at 5:55=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
> On Fri, Sep 19, 2025 at 6:25=E2=80=AFPM Nicolas Schichan <nschichan@freeb=
ox.fr> wrote:
> > Considering that the deprecation message didn't get displayed in some
> > configurations, maybe it's a bit early at the very least.
>
> I changed my opinion.
> Breaking users, who did not see a deprecation message at all,
> is unfair.
> I will send a patchset soon, which will remove initrd codepath,
> which currently contains deprecation notice. And I will put
> deprecation notice to
> other codepath.

Thanks

> Then in September 2026 I will fully remove initrd.

Is there a way to find some kind of middle ground here ?

I'm lead to believe that the main issue with the current code is that
it needs to parse the superblocks of the ramdisk image in order to get
the amount to data to copy into /dev/ram0.

It looks like it is partly because of the ramdisk_start=3D kernel
command line parameter which looks to be a remnant of the time it was
possible to boot on floppy disk on x86.

This kernel command line allows to look for a rootfs image at an
offset into the initrd data.

If we assume now that the rootfs image data starts at the beginning of
the initrd image and is the only part of the initrd image this would
indeed remove a lot of complexity.

Maybe it would be possible to remove the identify_ramdisk_image()
function and just copy the actual size of /initrd.image into
/dev/ram0. This would allow any file system to be used in an initrd
image (no just romfs, cramfs, minixfs, ext2fs and squashfs), and this
would simplify the code in init/do_mounts_rd.c greatly, with just the
function rd_load_image() and nr_blocks() remaining in this file.

I can send a patch for that but first I need to sort out my SMTP
issues from the other day.

Regards,

--=20
Nicolas Schichan

