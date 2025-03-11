Return-Path: <linux-arch+bounces-10676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796A6A5D35F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 00:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169F1189D093
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 23:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684A233159;
	Tue, 11 Mar 2025 23:50:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87522F3B0;
	Tue, 11 Mar 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737047; cv=none; b=cOTcS2z0i6IcPTS7Pd2Kvu06qA3gx9AkifYZ0wpQxR2iGq0sDwTy883MS9oaV2BFvPko9oF9VeYSogFGVDA6RnEjA59s01uS8R0mbseJXf7zSX4jZdzweOVFON+0XSlHLxKft11wehTa6FTc+aalZgzKyxQ9QctHD1ZtHOmMo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737047; c=relaxed/simple;
	bh=TXKNlSM0TKSxzdZrN7xHlcVd6ac01W3pV0YwZDnIsdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo6Y9vV41vlSLcAL3Ydtm3ANj4f30JCqgd2b9bdqIgxBzFHYIlmQiN95E2yy/J0qMyiGGWKttwNSymqA2ePbZZtWvellZs1g2CZNmAdxBiF7n71zBm/3mvj7McOYzMQ9KYVeCBMHfXRAejiIRx3eMlYsxRNNTPC8tFEr+FsXBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4767b3f8899so3665911cf.0;
        Tue, 11 Mar 2025 16:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741737044; x=1742341844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ/N6RDNJhsKkhEU6U2fwKdV9v3px1FNP1P5wQQOOck=;
        b=KGv0Hu0JnlGCMxXeEXybJzTN54SSnlHgCJiRXcA/WkwfNN2C3A3gRTXGc1PHV6xaNz
         ib44Lvkdl6YTw0wtdwrh5XkZ4A2oY1BIt7ufKyWe0/s2TLH+LpqT8P5hpBHEqwUVl7t7
         rETNolN9R9ACFN59XDeil85KxhTtdh/JnE6822Wutr36evOF9KtWKFnPOBn6jU8q+zdy
         sXwqN2De1cWfdD+K/k0BpsATX9jQIABq+E7cgaoIPFfNO8sq6A2UXslPBCaj4hNlhsHM
         g3Qv1aKSPdMJZRqhYgEGW2k+x6LMobpOJmEjofOy03O8MAFR6LDl2A7jMUSy3Y/8O0Ng
         z1bg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xySYAhN7APpMvWRDpDr7Pr5gNpEQq6+UJJOjA58jzzAs5QcgKSzikzClajjlR/0FDVDyZQj77bTV0A==@vger.kernel.org, AJvYcCUHhE1kKKT2G6TG+VcgoaTfe0HGAlcjkoA6OpNhBX01HgE8REi6/Hsn5DC2DzXil7ryX3FHKx624PQwrw==@vger.kernel.org, AJvYcCUQpSbcmsNCwKtVKORapuoJpQbSyOBKcQw1yMyqqZIjcmQGtuGeltqIX5DzDIuAu9OxY6n2kYbUE+kIvQ==@vger.kernel.org, AJvYcCUf6VjIrkHMCWNnFZ6GoGsCt6APRuHGmJ09Jo6629L/2y0QC5WWEtXz+X78LXO+0Oi5uaNfZyYOpQ+mFL7p@vger.kernel.org, AJvYcCUgCsubRse2Eb5Nk2CU9WbvK85oAf7BYfiAmzp0fgcig+gbqtepsgN/NG73SlqEb/1IqpXwS7hKbYo=@vger.kernel.org, AJvYcCVx2ei5MrJMJ/ZSTKdvdHuNW2Avo/dsMt6XzkWuZoYoK+lSJ6w9jBzNee52rC0bG6oF9YK3PZqG68XwsA==@vger.kernel.org, AJvYcCWCMJkXd53HONhsSwAclqWdzv8LptoPkQONFi6vMhO7sG8FgsmUTDlSvCXymln3jhMcbSnio9LGsetaig==@vger.kernel.org, AJvYcCWY0gmtDOw3MgZXKk0JzeEX3VZ00CTPoQnI8Vl8aRqSj0pLRTPJp0zqqfexUbiVhy1yvWU/F7GRg1p12IQflg==@vger.kernel.org, AJvYcCX1FWBmiN5EnNTxqeWPk4HRapuFO1rVKlwDHzPciomO9xyzQmXNxHEr89hh3MBbjhofXSsupAt0hq9n6k0R@vger.kernel.org, AJvYcCXaAncR1lob
 4nPNMX2xx9kNYbmjUss0guakHTNFSpMze4cqxjcmUMXjxY6iY4LEpOhtIc8JipNku7diZ43csFU=@vger.kernel.org, AJvYcCXmzO0sDbfefmIwzKwKG9Q+KVE1pWtpcTh5OmNWpiBCUjm/N23aSWETVqayakyoJ6ngcGcDtGOf6RpwPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjEFW/gjU09IOfpSBwwDpitjG52v+lwmYcIZU8plH4rA4FgSo
	VRHFnyZHpMohFSki6T+Vbmurg1ZllLbgqPgA5VjH3FljBuIb0Vyt3p2Oa92F
X-Gm-Gg: ASbGncvRt7wsJBZkor7/yL/sad8FKy2ZjXurwESDbVJQot3VP+ow1FOfQeKt9Ll+UXZ
	pAUGMZFkUZwtqua+OeufdqJrwFnSU/wCFLzrswsr8dD3ola2QsGNyYfbJGCP0Q/jt5BQ1V8ScpB
	cAyrHEIwwmxFSL1usgCJJllgphtoJcPIiPN0cUfqeRb8742nZtR+R6b651DCpykGTCflJmJLoZ6
	kjdhKMr4f5aD2Fw/ZMEIRs86qWZ2prLzRBdT32qhehoLyR8fMUy5mZt30MF8QIRho8csO2hz16f
	vJ7lCLIIg7Wd+eOLJJERLmEdSeKWB2P6aCSXrCthYd4+bjH/Y9O1XrvYx5VNQsJvNlnw0ph+1BM
	uY7CJorAXCNao+3IxEiTAVw==
X-Google-Smtp-Source: AGHT+IGALKglwXNRoQ9JXD4IpnpoNwy1ysC7RXpt0d7G0uAlcb34NlJWbtFYr/UNudjbnPuk8c8BTg==
X-Received: by 2002:a05:6102:548c:b0:4b3:fee3:2820 with SMTP id ada2fe7eead31-4c34ddc00f0mr3361686137.9.1741729303096;
        Tue, 11 Mar 2025 14:41:43 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb4217e4sm2456115137.4.2025.03.11.14.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 14:41:43 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-524038ba657so270806e0c.0;
        Tue, 11 Mar 2025 14:41:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFifAk/Bfr5xmQD0nc2vtczAQO+RA5Gf/Kp1151AsLI2TVMbtJFi8fx0fDTGzoPtw69dY5OVYnTCIB51ryEo4=@vger.kernel.org,
 AJvYcCUUxbOv97BbHSBh9ELshx2qS+VAzrOMnFYTu4p0aDdG5mCGvWSLUuLXRqX56gOC7Ua9RJI8vv5/uMm2XA==@vger.kernel.org,
 AJvYcCUf2za9+Kcoi+DkvqtsF2VjqJAxm63Td0aZOYe7NLttdHFTHHB1WHnkVlqLh+M9RtuYaR2mXtu17zkQWA==@vger.kernel.org,
 AJvYcCUrSUuolE9quGEQmEQWgYtaGkIvK0BPW72W7uAk/D4IbQARqwkO9UOrTI51YPp7Roh7BWSKs3K+HzoxFA==@vger.kernel.org,
 AJvYcCVNR8UwTRXEu7uaE1WoxiGl9fgnZuOyAvzOvuOAgo9r/amC/e/rYMsUMuXZdRgete3OU+Cz6neIGVE=@vger.kernel.org,
 AJvYcCVTHUDVajnbIMFbfCbzNM1WLvlwq5xM7cu73Mv1/ZO7MxegKtib1dJ4cLpRoqG3fXq7MeYki4RpFI3Vv05p@vger.kernel.org,
 AJvYcCVTynyIxtGuzP+6NLr/p4AVqqdrH8s46p4oY4cJoe1PR2S7ewuzdJPzSwhBWiu+mfZ8b3pdMPGW7qyY/Q==@vger.kernel.org,
 AJvYcCVh1QlOPvgB2z/m7Pv3Gxeba+FaFodKsCRWfKUDGkI5RPuxobv/1z5+ruMhcaPp7d8p4RkDWC/RVGY5BQ==@vger.kernel.org,
 AJvYcCWZO4d3P3IBdkgtVvdxiKT/RGAcOioBEwSicjFhcPUZmasf7GMWprZCeH8EZhQoClGKRWu2Ww7zXnePJL1/yA==@vger.kernel.org,
 AJvYcCXRxHbnrkrmekqKF+QpTX+oE70XJ3y3t/rfK96zvuzUDs6AkGaYrdk7kBLVghx619Vq9PJmQ00ycM432g==@vger.kernel.org,
 AJvYcCXo9ljE8GT9CCpAJr0xUN9j4QHKJUhNbAR/KRiLxzcSUa05YTW6Jz7rIPLU86HQgWiSiwITc5dfxQxkwtS8@vger.kernel.org
X-Received: by 2002:a05:6122:489c:b0:523:e4c6:dddb with SMTP id
 71dfb90a1353d-52419478380mr4380371e0c.0.1741729302782; Tue, 11 Mar 2025
 14:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk> <Z9Cl8JKkRGhaRrgM@kernel.org>
 <5e40219b-f149-4e0f-aa10-c09fa183945e@sirena.org.uk>
In-Reply-To: <5e40219b-f149-4e0f-aa10-c09fa183945e@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2025 22:41:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGnBeo69NkYsv35YHp6H9GJSu-hoES2A8_0WhpX1zFhQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jp2UP71Gi3RsrYhaKY-FGNeXSzj4L3BI-snK3mtBDJzZMW7SrRY1lIN6cU
Message-ID: <CAMuHMdUGnBeo69NkYsv35YHp6H9GJSu-hoES2A8_0WhpX1zFhQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

On Tue, 11 Mar 2025 at 22:33, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 11, 2025 at 11:06:56PM +0200, Mike Rapoport wrote:
> > On Tue, Mar 11, 2025 at 05:51:06PM +0000, Mark Brown wrote:
> > > This patch appears to be causing breakage on a number of 32 bit arm
> > > platforms, including qemu's virt-2.11,gic-version=3.  Affected platforms
> > > die on boot with no output, a bisect with qemu points at this commit and
> > > those for physical platforms appear to be converging on the same place.
>
> > Can you share how this can be reproduced with qemu?
>
> https://lava.sirena.org.uk/scheduler/job/1184953
>
> Turns out it's actually producing output on qemu:
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.14.0-rc6-next-20250311 (tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1741691801
> [    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] random: crng init done
> [    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0x00000000
>
> - I'd only been sampling the logs for the physical platforms, none of
> which had shown anything.

Hangs that early need "earlycon", which the qemu boot above does have.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

