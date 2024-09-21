Return-Path: <linux-arch+bounces-7361-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D997DED9
	for <lists+linux-arch@lfdr.de>; Sat, 21 Sep 2024 22:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728572811DF
	for <lists+linux-arch@lfdr.de>; Sat, 21 Sep 2024 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D9351C3E;
	Sat, 21 Sep 2024 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKg+nXU1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C7963B9;
	Sat, 21 Sep 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726951672; cv=none; b=ALvg/0ER+gVokWnq42VYW95imXBU5ONyfSN26u2cfnBr7c/ni2tKlGXMrkR3owQB/N7QZETqu71ws6BZJPTnssKIXdeUd6P4r6pFSoBSULiVYuWUoMTJVHTlMXTr8keAiTge6+9ckB0MfhoTPNJLgeUEMS02CmjdTl4NYoKjEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726951672; c=relaxed/simple;
	bh=rH7Dd3F/dN69MjOyihHAnz5rb6ZghANW3/Yr+QCK5vc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YqzpRQeoUUzQQmlbFzEKSvSaXJ2jYCI0+sya/ESKeZ1QINjmjXk5f+/4MHdiDaxiQcjajn7A8sJOl+Nm4Luwp/ftu8A/YdjLY2kW9yp5jC6W8tLZ7pH/3n2pTg5fEkJPwRlyatFhfcBGx09RN77mP7E0rDEcUBEWtMb7AwdHTvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKg+nXU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50464C4CEC2;
	Sat, 21 Sep 2024 20:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726951671;
	bh=rH7Dd3F/dN69MjOyihHAnz5rb6ZghANW3/Yr+QCK5vc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hKg+nXU1aYxGePNWhTIE8dsBsIfsAqTtDNnuthtmAZE5rUruPkUtzAK/P7Y3jQpuQ
	 0iGCWRteM1b38mWRKlI34PpfmUlGmdTSd7QlDzcgjq9JZdFvvxOEAd+jdR3dMVBd1P
	 wPl8X5jzLfN06q+FcQjH+qv7C0dZeZ2AYlhyqfqbbCZ/vFNhnoMFNHYPfpfWiqUdgs
	 UFkeDAV5K358rvaQRFHISVEuA2fvulH7az9mxmh854UFfTCXoQnDa6qvW6Z0lwSB6M
	 IxSoNEPk488RziMwMnaB5dfkgmKSPJiJRz4qg76SVbMLimGtlmNT27GradvHf7Da9k
	 S857xSA9cfrFg==
Message-ID: <d87530b846d0dc9e78789234cfcb602a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZtcBHvI9JxgH9iFT@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com> <12d0909b1612fb6d2caa42b4fda5e5ae63d623a3.1724159867.git.andrea.porta@suse.com> <2113b8df52164733a0ee3860bb793d6e.sboyd@kernel.org> <ZtcBHvI9JxgH9iFT@apocalypse>
Subject: Re: [PATCH 05/11] vmlinux.lds.h: Preserve DTB sections from being discarded after init
From: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley <conor+dt@kernel.org>, David S. Miller <davem@davemloft.net>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahrenst@gmx.net>, Will Deacon <will@kernel.o
 rg>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
To: Andrea della Porta <andrea.porta@suse.com>, Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 21 Sep 2024 13:47:49 -0700
User-Agent: alot/0.10

Quoting Andrea della Porta (2024-09-03 05:29:18)
> On 12:46 Fri 30 Aug     , Stephen Boyd wrote:
> > Quoting Andrea della Porta (2024-08-20 07:36:07)
> > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/=
vmlinux.lds.h
> > > index ad6afc5c4918..3ae9097774b0 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> >=20
> > It would be nice to keep the initdata properties when this isn't used
> > after init as well. Perhaps we need another macro and/or filename to
> > indicate that the DTB{O} can be thrown away after init/module init.
>=20
> We can certainly add some more filename extension that would place the
> relevant data in a droppable section.=20
> Throwing away the dtb/o after init is like the actual KERNEL_DTB macro th=
at
> is adding teh data to section .init.data, but this would mean t would be
> useful only at very early init stage, just like for CONFIG_OF_UNITTEST.
> Throwing after module init could be more difficult though, I think,
> for example we're not sure when to discard the section in case of deferred
> modules probe.
>=20

This patch can fix a modpost warning seen in linux-next because I have
added DT overlays from KUnit tests while kbuild has properly marked the
overlay as initdata that is discarded. See [1] for details. In KUnit I
doubt this really matters because most everything runs from __init code
(even if it isn't marked that way).

I'm thinking that we need to make dtbo Makefile target put the blob in
the rodata section so it doesn't get thrown away and leave the builtin
DTB as part of init.rodata. Did you already do that? I see the kbuild
tree has removed the commit that caused the warning, but I suspect this
may still be a problem. See [2] for the next series where overlays
applied in the test happen from driver probe so __ref is added.

If we simply copy the wrap command and make it so that overlays always
go to the .rodata section we should be good. Maybe there's some way to
figure out what is being wrapped so we don't have to copy the whole
thing.

Finally, it's unfortunate that the DTBO is copied when an overlay is
applied. We'll waste memory after this patch, so of_overlay_fdt_apply()
could be taught to reuse the blob passed in instead of copying it.

-----8<----
diff --git a/scripts/Makefile.dtbs b/scripts/Makefile.dtbs
index 55998b878e54..070e08082cd3 100644
--- a/scripts/Makefile.dtbs
+++ b/scripts/Makefile.dtbs
@@ -51,11 +51,25 @@ quiet_cmd_wrap_S_dtb =3D WRAP    $@
 		echo '.balign STRUCT_ALIGNMENT';					\
 	} > $@
=20
+quiet_cmd_wrap_S_dtbo =3D WRAP    $@
+      cmd_wrap_S_dtbo =3D {								\
+		symbase=3D__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(notdir $*));	\
+		echo '\#include <asm-generic/vmlinux.lds.h>';				\
+		echo '.section .rodata,"a"';						\
+		echo '.balign STRUCT_ALIGNMENT';					\
+		echo ".global $${symbase}_begin";					\
+		echo "$${symbase}_begin:";						\
+		echo '.incbin "$<" ';							\
+		echo ".global $${symbase}_end";						\
+		echo "$${symbase}_end:";						\
+		echo '.balign STRUCT_ALIGNMENT';					\
+	} > $@
+
 $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 	$(call if_changed,wrap_S_dtb)
=20
 $(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
-	$(call if_changed,wrap_S_dtb)
+	$(call if_changed,wrap_S_dtbo)
=20
 # Schema check
 # ------------------------------------------------------------------------=
---

[1] https://lore.kernel.org/all/20240909112728.30a9bd35@canb.auug.org.au/
[2] https://lore.kernel.org/all/20240910094459.352572-1-masahiroy@kernel.or=
g/

