Return-Path: <linux-arch+bounces-7362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BF797E088
	for <lists+linux-arch@lfdr.de>; Sun, 22 Sep 2024 10:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA1B1C208F1
	for <lists+linux-arch@lfdr.de>; Sun, 22 Sep 2024 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99589192D9B;
	Sun, 22 Sep 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJVKgGiG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542672C6A3;
	Sun, 22 Sep 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726992891; cv=none; b=fVzr3cTR31rxlom8+gAi4SPtpVJXadMY+ejMv8rhXdtCEgWGpZHSmEFLMnzSywJWe5fN14K8QECvIhrR18Ti5oAAADBzw7/b8l0KslP4T4FYKjqjHQfFZ9GkCQZD0mWP/voOIOpLqbx5j7oglwT1ZJX/798so4wbjAcolRoUn/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726992891; c=relaxed/simple;
	bh=daVW5nkkXHXbUa28cwr4Mm6p9F17c5lXuRDCLv5wpyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjYjn5RPaCLIyu736UpVBys6GGHwJIXOM72Q9Sxxq14K4FC2JngESBkXVCNxPbwN4+oIBwKepbUfqn+4bQBZGAdXnO8vtmQHoepLaNvdGjlSUFw289G8iMi/60FVq3hHKkBb57+9te/sp19m9qwYxbcH6csJvDMXQWx7TPPFzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJVKgGiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6E6C4CED0;
	Sun, 22 Sep 2024 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726992890;
	bh=daVW5nkkXHXbUa28cwr4Mm6p9F17c5lXuRDCLv5wpyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BJVKgGiGR7tSchChAfCiRfZd6kgnYLQJM8Q16qEF1dlbLiaT8aHW7pUbJVSz7d742
	 nfyGL1SuA0Ir2P2+Vucx+dRS3ejAvBt10hmGq+vpDenAVSL7Mu9tE8BkLcKX655v+E
	 M0YIx325UYT7E2dmSHZ2Pjpf+IiVNJNRuN3INM5+X5RgP/Y73vYdS+EU1pG/txMyfA
	 uXhpkmzVJwvwpPkFaVuSxHi6hmK6oeJ25u+1rNplzqKuCoZk8iID6kux2G72mGe/Cz
	 17bU021Nh4eXF+cc61SNXlvkCyCowmHTJmonwMyp4/2rTLO3PMZSBYTiEFHUiEmi7z
	 1yCUWajynF+fA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365cf5de24so4171532e87.1;
        Sun, 22 Sep 2024 01:14:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3z8ktaVsLUNTKJXKMzK9cI8CAcZKfzV01rXYpHsCrqeCsncKmumcx2vAqsS5w8VzbY9eAmgXxeI3c1Q==@vger.kernel.org, AJvYcCUJY83GPPbwWypCvG1NidtE1Gxim9PjLVRKB8NNksgkTchHhT9H2cO+DSbXPlVA+2OYQ1yN32gyh/mhWA==@vger.kernel.org, AJvYcCVdF4ahk5Cc434JV6yE7XXYFAziAj2qYfhcj2Bl07bx1923rAFB5ZdU6ul3kLywlrEposZP4W+4qdOMQRoS@vger.kernel.org, AJvYcCVioPEDm0PcVQ9dETExaiYWHKWvNaoaSBV4S/eSl/cU++YVMrijgorqRnEEdgMOTYjesTuKSc5UXdr/@vger.kernel.org, AJvYcCX3X23/+KRucze82lXBGXe0OiSgWK9ISEVhMOgdHrmsf4wC6mv/K9c6qIsC/L5IsHVYU0+u0W8hvJUV@vger.kernel.org, AJvYcCX5aTa5pE0KKMfdtAaEMFITxln5W/iJ5UGmcJcV+7o60iuBweAnXLyhz7FDMorJ6GklOQ5VzqSsMHNo@vger.kernel.org, AJvYcCXUJWtK0/sqAUU0zPCYEJVBDEmkUITHZgOLT8PUoez/0KvLIQmwojOpezKW5TbKgxgwng/PdLh9AavKqlRW@vger.kernel.org, AJvYcCXvhwT8aC6UCEH2gl1tKAu/C6Knqlf3HnZRovAk5TeYf+Y9CsmWbii/8DUDv5XFWLzThB3XZ+Sz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm38pquwDnzp64QIRpZnEe0GdIqiSur1c4R6OzrYCwMKR+2iSx
	GA+nqMi3bgu6QSJ+abz050gyqwnTO6vRJIKV0tUlS6gaD3Ycp0tzpP24Fv0R/QYFC3iWvZIht9X
	kcwtGEF/tfcLvFOCJyLoDTsX1H8M=
X-Google-Smtp-Source: AGHT+IEkGHmluJPYdY5Kkg0y6DLMIw/ocbENg+Gy+OgcetK1Xjl0OGvt1ds6StzBsAWxCQ0BMMYkAc8LLyrnCJUG5uk=
X-Received: by 2002:a05:6512:281c:b0:533:44a3:21b9 with SMTP id
 2adb3069b0e04-536acf6abdemr3884035e87.1.1726992889297; Sun, 22 Sep 2024
 01:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724159867.git.andrea.porta@suse.com> <12d0909b1612fb6d2caa42b4fda5e5ae63d623a3.1724159867.git.andrea.porta@suse.com>
 <2113b8df52164733a0ee3860bb793d6e.sboyd@kernel.org> <ZtcBHvI9JxgH9iFT@apocalypse>
 <d87530b846d0dc9e78789234cfcb602a.sboyd@kernel.org>
In-Reply-To: <d87530b846d0dc9e78789234cfcb602a.sboyd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 22 Sep 2024 17:14:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEx52BYMYfNu+xj8sNmdtH9XfPapdhJDrsbDo43aD3Dg@mail.gmail.com>
Message-ID: <CAK7LNAQEx52BYMYfNu+xj8sNmdtH9XfPapdhJDrsbDo43aD3Dg@mail.gmail.com>
Subject: Re: [PATCH 05/11] vmlinux.lds.h: Preserve DTB sections from being
 discarded after init
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 5:47=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Andrea della Porta (2024-09-03 05:29:18)
> > On 12:46 Fri 30 Aug     , Stephen Boyd wrote:
> > > Quoting Andrea della Porta (2024-08-20 07:36:07)
> > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generi=
c/vmlinux.lds.h
> > > > index ad6afc5c4918..3ae9097774b0 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > >
> > > It would be nice to keep the initdata properties when this isn't used
> > > after init as well. Perhaps we need another macro and/or filename to
> > > indicate that the DTB{O} can be thrown away after init/module init.
> >
> > We can certainly add some more filename extension that would place the
> > relevant data in a droppable section.
> > Throwing away the dtb/o after init is like the actual KERNEL_DTB macro =
that
> > is adding teh data to section .init.data, but this would mean t would b=
e
> > useful only at very early init stage, just like for CONFIG_OF_UNITTEST.
> > Throwing after module init could be more difficult though, I think,
> > for example we're not sure when to discard the section in case of defer=
red
> > modules probe.
> >
>
> This patch can fix a modpost warning seen in linux-next because I have
> added DT overlays from KUnit tests while kbuild has properly marked the
> overlay as initdata that is discarded. See [1] for details. In KUnit I
> doubt this really matters because most everything runs from __init code
> (even if it isn't marked that way).
>
> I'm thinking that we need to make dtbo Makefile target put the blob in
> the rodata section so it doesn't get thrown away and leave the builtin
> DTB as part of init.rodata. Did you already do that? I see the kbuild
> tree has removed the commit that caused the warning, but I suspect this
> may still be a problem. See [2] for the next series where overlays
> applied in the test happen from driver probe so __ref is added.
>
> If we simply copy the wrap command and make it so that overlays always
> go to the .rodata section we should be good. Maybe there's some way to
> figure out what is being wrapped so we don't have to copy the whole
> thing.
>
> Finally, it's unfortunate that the DTBO is copied when an overlay is
> applied. We'll waste memory after this patch, so of_overlay_fdt_apply()
> could be taught to reuse the blob passed in instead of copying it.
>
> -----8<----
> diff --git a/scripts/Makefile.dtbs b/scripts/Makefile.dtbs
> index 55998b878e54..070e08082cd3 100644
> --- a/scripts/Makefile.dtbs
> +++ b/scripts/Makefile.dtbs
> @@ -51,11 +51,25 @@ quiet_cmd_wrap_S_dtb =3D WRAP    $@
>                 echo '.balign STRUCT_ALIGNMENT';                         =
               \
>         } > $@
>
> +quiet_cmd_wrap_S_dtbo =3D WRAP    $@
> +      cmd_wrap_S_dtbo =3D {                                             =
                 \
> +               symbase=3D__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(n=
otdir $*));      \
> +               echo '\#include <asm-generic/vmlinux.lds.h>';            =
               \
> +               echo '.section .rodata,"a"';                             =
               \
> +               echo '.balign STRUCT_ALIGNMENT';                         =
               \
> +               echo ".global $${symbase}_begin";                        =
               \
> +               echo "$${symbase}_begin:";                               =
               \
> +               echo '.incbin "$<" ';                                    =
               \
> +               echo ".global $${symbase}_end";                          =
               \
> +               echo "$${symbase}_end:";                                 =
               \
> +               echo '.balign STRUCT_ALIGNMENT';                         =
               \
> +       } > $@
> +
>  $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>         $(call if_changed,wrap_S_dtb)
>
>  $(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
> -       $(call if_changed,wrap_S_dtb)
> +       $(call if_changed,wrap_S_dtbo)
>
>  # Schema check
>  # ----------------------------------------------------------------------=
-----
>
> [1] https://lore.kernel.org/all/20240909112728.30a9bd35@canb.auug.org.au/
> [2] https://lore.kernel.org/all/20240910094459.352572-1-masahiroy@kernel.=
org/







Rather, I'd modify my patch as follows:



--- a/scripts/Makefile.dtbs
+++ b/scripts/Makefile.dtbs
@@ -34,12 +34,14 @@ $(obj)/dtbs-list: $(dtb-y) FORCE
 # Assembly file to wrap dtb(o)
 # ------------------------------------------------------------------------=
---

+builtin-dtb-section =3D $(if $(filter arch/%, $(obj)),.dtb.init.rodata,.ro=
data)
+
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_wrap_S_dtb =3D WRAP    $@
       cmd_wrap_S_dtb =3D { \
  symbase=3D__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(notdir $*)); \
  echo '\#include <asm-generic/vmlinux.lds.h>'; \
- echo '.section .dtb.init.rodata,"a"'; \
+ echo '.section $(builtin-dtb-section),"a"'; \
  echo '.balign STRUCT_ALIGNMENT'; \
  echo ".global $${symbase}_begin"; \
  echo "$${symbase}_begin:"; \




--=20
Best Regards
Masahiro Yamada

