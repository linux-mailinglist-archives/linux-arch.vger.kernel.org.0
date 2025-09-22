Return-Path: <linux-arch+bounces-13717-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7C4B920D3
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DFB3AD9C1
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954FB2E22BF;
	Mon, 22 Sep 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GXukuvo9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7bn3X/3"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518527E05E;
	Mon, 22 Sep 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556206; cv=none; b=jN80v/J7nwhtI3mdCiDgA1hp+KIb1UxWtBXbTqcuvpPWBVLnL4306jlR2k2G3KN3WOimDdu2KuQoemHa96T6c6mD+DusI+KDLxORGDY4VHVpKdIarG7j+jGEeM9lQig8LdbFujqSQ29Eae7c0CzaFtcdmDG8x+p3Kwit09BkDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556206; c=relaxed/simple;
	bh=zVcxQaLLJjp1tgHIu6BUmG3kRKT1XrYgdbrL0AEQaDo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ntb5dc3CxWxEWDDsVe+2RsSk+pzYQC43KKoRPwFZvk9/eQavkojTbqWREakmYWfT6G+KM1gI/4IDsAoMhe0zk8CATNVJF7mjl+NLalBvZiuaY/ScZ6Z3OmAPL+EfvikvmvBhUMqsnPaTAi8dgKWeksa8uNkOuWAr8ZiRkXHKfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GXukuvo9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7bn3X/3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D05861400185;
	Mon, 22 Sep 2025 11:50:01 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 22 Sep 2025 11:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758556201;
	 x=1758642601; bh=A/FyWbZB2niZ9en3LsHe35IO/14v7pXOglezFN2AlWc=; b=
	GXukuvo9HfHHE7Ch0UvVgGtKCHejh4qkCDkyNu4JGLRrn/XbHZKK9jSBO3gQEQL5
	UQtX7idGz47mhH7z11oyJU9ghw3dEVaL1sC2WFt6JOmnRaZm96+Wopwn5Xk4OFQ5
	C8NjsSPpc/g1mWgF3Zbs4eQfDI+fqKlk6/vATYYik/wcaN/gSdFyOO5pz4t54Qxv
	z69vmjhTCD77O7YOap5eiDiFCg10m8j1iG9kGjPOelUSRZCFXeXLm/W0A6Xeicxb
	F+iRraV6ytvldXSVJlwmtYjn6DYFrtJ+6JvA50jIG1XB5dfoY7HnBMHwKXkLTYYT
	udZP2qh+fdADqPWQBn0dQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758556201; x=
	1758642601; bh=A/FyWbZB2niZ9en3LsHe35IO/14v7pXOglezFN2AlWc=; b=j
	7bn3X/3S4zNwVQrR4swQI02YBvZdFVrjtrNn0+JUcMgmvrraC88wOncelbKWc1Th
	w8fSVLGVZ+lanR7vaDrZqQq0NuwgTQ0FxjIOGLGddn8Me6GmRW3u5fwnU6p16/yL
	FU2TKTvPiFMDk9q8dcVAv0Ow/j5P5ALT5Yu73+HlskVDG7b8ijweRqNhhQq6scgW
	sfoNGje6VFvCexTMhym37GRw+aaVGO+xj9K5+WeIxQRtQBMRFouGpQrVxZpgo7Mg
	7h03vvzAdKel2mDG5/VFNg3g4Q93CyTo/JeVnfitlrL6P96L1OeI3n75M1NC65Xc
	ATSA5e98FTiqhwXw9a16w==
X-ME-Sender: <xms:KXDRaIPdW4M2I4qDucs-xWvS2koaNKJyAbuuo6Zf7d4RrT9efo89iQ>
    <xme:KXDRaJzWcyGqfc8lA8tgyAnvyWczTmKaM7oq9jx1xrCVMjJomqWj3gAFjVPh7zQlo
    AGN5N1vQjIliYQtBSekwYNwcmsTvw_yVqd72hpEelieI2EIfxP2oJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeehjeejhfeftdfgieehleefleehgedugfevieeiveeivedvudegheehudefkefhfeen
    ucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkhdrrh
    huthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhm
    sehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehfthhhrghinh
    eslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepghgvvghrtheslhhinhhugidq
    mheikehkrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpth
    htoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KXDRaCXCD4_IqPgTPcgRS5F4eYgIBIekL_vdE3-TV_8JGJMczBDi-Q>
    <xmx:KXDRaKZScN8-Pt9xBwfwMnFRlF_R_bVv9Da_Zcp6HvpySFtXmDWz7g>
    <xmx:KXDRaByObfqIhq1dbzNWuPkpmtOD0okkVtWf7gI_nCW11H2TkZidZQ>
    <xmx:KXDRaC3n0IrrEzacIH8hp2BL1e9lhtuI71ldcaz10YyV5hCfArc9FQ>
    <xmx:KXDRaGGzEHaGyqAw6MI1T3ZrHKGV_akfAvGa9k5iqVItpPKL1qOzQKtC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 027DC700065; Mon, 22 Sep 2025 11:50:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Sep 2025 17:49:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Message-Id: <61895919-76ef-485d-ad5c-0cff866566f3@app.fastmail.com>
In-Reply-To: <0d93c6e5-a4cb-2f5c-e87d-e42a283324d6@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
 <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
 <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
 <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org>
 <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
 <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
 <534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fastmail.com>
 <0d93c6e5-a4cb-2f5c-e87d-e42a283324d6@linux-m68k.org>
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic operations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 17, 2025, at 04:14, Finn Thain wrote:
> On Tue, 16 Sep 2025, Arnd Bergmann wrote:
>> On Tue, Sep 16, 2025, at 02:16, Finn Thain wrote:
>>
>> Right, especially since those structure definitions are more likely to 
>> be used on older drivers, there are probably some that do happen on 
>> m68k. On the other hand, any driver that is portable to non-m68k targets 
>> won't have this problem.
>> 
>
> Yes, but only inasmuchas drivers are completely portable. Any data 
> structure accessed or declared using #if conditional code would defeat 
> that kind of reasoning.

Sure, but those are extremely rare. If there is a structure definition,
it's usually done in a way that describes the hardware and is already
densely packed. There are only a handful of compile-time checks for
CONFIG_M68K and __m68k__ in the kernel, and none of those are
around data structure definitions.

>> I tried a trivial m68k defconfig build with "-Wpadded -malign-int" and 
>> found 3021 instances of structure padding, compared to 2271 without 
>> -malign-int. That is still something one could very reasonably go 
>> through with 'vim -q output', as almost all of them are obviously 
>> kernel-internal structures and not problematic.
>> 
>
> So, 3021 is the number of structs potentially needing to be checked? This 
> is not the kind of upper bound I consider feasible for careful manual 
> editing (it's worse than I thought). We need the compiler to help.

It's the number of add pads, so there are some structures that
show up many times in that list.

There would be significantly more than those 3021 if you include
drivers that are not in defconfig. An 'allmodconfig' build brings the
number up to 17000, but it's easy to quickly bring that number down
again by excluding stuff that is obviously specific to a random Arm
SoC. I would also exclude all of fs/* and most of net/* as being clearly
irrelevant here.


In a given file, there are likely many instances either in the
same struct or a set of related structs, where all can be discarded
after looking at the pattern in that file.
See the end of this email for a count by directory.

I think just doing the uapi headers is probably enough to avoid
accidentally introducing a new ABI when either the kernel or userspace
gets built with -malign-int, everything inside of the kernel is
at most a bug that can be fixed later.

>> A quick manual scan only shows a number of uapi structures but very few 
>> drivers. There are a few hardware structures that are internally packed 
>> but in a structure that has gets an extra two bytes of harmless padding 
>> at the end (struct CUSTOM, struct amiga_hw_present, struct 
>> atari_hw_present, struct TT_DMA, struct pcc_regs). 
>
> I wouldn't assume that padding at the end is inconsequential. I think the 
> analysis requires comparing object code. E.g. add the same padding 
> explicitly to see whether it alters object code under -mno-align-int.

There is clearly a difference in uapi headers, especially when
it gets passed through an ioctl that encodes the size of the structure
in the command code.

For the structures I listed above, I can see no way it would actually
make a difference.

>> The only ones I could find that actually seemed suspicious are:
>> 
>> arch/m68k/include/asm/atarihw.h:426:10: warning: padding struct to align 
>> 'dst_address' [-Wpadded] arch/m68k/include/asm/openprom.h:76:13: 
>> warning: padding struct to align 'boot_dev_ctrl' [-Wpadded] 
>> drivers/net/ethernet/i825xx/82596.c:250:1: warning: padding struct size 
>> to alignment boundary
>> 
>> I'm sure there are a few more, but probably not a lot more. See 
>> https://pastebin.com/Z2bjnD0G for the full list. I've also tried 
>> annotating the ones that show up in defconfig, see diffstat below.
>> 
>> Unfortunately I found no way of annotating a struct a whole to use the 
>> traditional padding rules: "#pragma pack(push, 2)" lowers the alignment 
>> of all struct members to two bytes, including those with an explicit 
>> alignment like __aligned_u64. A struct-wide __attribute__((packed, 
>> aligned(2))) seems even worse, as it makes all members inside of the 
>> struck tightly packed and only aligns the struct itself.
>> 
>> This means all misaligned members have to be individually marked as 
>> __packed, unless someone comes up with another type of annotation.
>> 
>
> Right. The trick will be to annotate the affected struct members by 
> automatic program transformation.

I don't think automated transformation is going to work well here,
as you may not want the same approach in each case, depending
on what the code is:

- it may be enough to annotate a single member as packed in
  order to make the entire structure compatible
- some structures may have lots of misaligned members, but
  no holes, so a global __attribute__((packed, aligned(2))) on
  that struct is cleaner
- if there are holes, some strategic additions of explicit
  padding can be cleaner than annotating each misaligned
  member.
- automation won't be able to tell whether a structure is
  ABI relevant or not
- similarly, many files are not going to be interesting for
  m68k. E.g. if drivers/infiniband has an ABI that is
  different for -malign-int, that can likely be ignored
  because nobody cares in practice.

> It would be sufficient to have a plug-in to list the sites of all members 
> potentially needing annnotation. The list could be manually pared down and 
> the actual annotating could be scripted. Note that this list would be 
> shorter than a -Wpadded list, because there's a bunch of padding that's 
> not relevant.

Yes, that should work to rule out many instances and to find out
exactly where packing attributes are required.

    Arnd

      2 arch/m68k/atari
      5 arch/m68k/include/asm
     39 block
      1 block/fs
     11 block/partitions
     34 crypto
      6 crypto/asymmetric_keys
     10 drivers/accessibility/speakup
     11 drivers/android
     12 drivers/android/tests
     15 drivers/ata
      8 drivers/auxdisplay
     11 drivers/base
      5 drivers/base/firmware_loader
      2 drivers/base/firmware_loader/builtin
     10 drivers/base/regmap
      2 drivers/base/test
      2 drivers/bcma
     18 drivers/block
      2 drivers/block/aoe
      7 drivers/block/drbd
      4 drivers/block/null_blk
      7 drivers/block/rnbd
      2 drivers/block/zram
     55 drivers/bluetooth
      4 drivers/bus
      2 drivers/bus/mhi/ep
      4 drivers/bus/mhi/host
      3 drivers/cdx
      6 drivers/cdx/controller
      3 drivers/char
      8 drivers/char/hw_random
     35 drivers/char/ipmi
     11 drivers/char/tpm
      1 drivers/char/tpm/eventlog
      3 drivers/char/tpm/st33zp24
      1 drivers/char/xillybus
     48 drivers/clk
      5 drivers/clk/actions
      8 drivers/clk/bcm
      8 drivers/clk/imx
      6 drivers/clk/ingenic
     11 drivers/clk/mediatek
     24 drivers/clk/qcom
      2 drivers/clk/ralink
     21 drivers/clk/renesas
      6 drivers/clk/samsung
      1 drivers/clk/sifive
      9 drivers/clk/socfpga
     11 drivers/clk/sophgo
      3 drivers/clk/sprd
      2 drivers/clk/starfive
     17 drivers/clk/sunxi-ng
      1 drivers/clk/ti
      1 drivers/clk/versatile
      6 drivers/clk/visconti
      2 drivers/clk/xilinx
     43 drivers/clocksource
      1 drivers/comedi
     48 drivers/comedi/drivers
      6 drivers/comedi/drivers/tests
      9 drivers/counter
     37 drivers/crypto
      3 drivers/crypto/amlogic
      4 drivers/crypto/aspeed
     28 drivers/crypto/caam
     17 drivers/crypto/ccree
      3 drivers/crypto/hisilicon/sec
      7 drivers/crypto/inside-secure
      5 drivers/crypto/inside-secure/eip93
      2 drivers/crypto/intel/ixp4xx
      4 drivers/crypto/intel/keembay
      3 drivers/crypto/marvell/cesa
      7 drivers/crypto/qce
      4 drivers/crypto/starfive
      6 drivers/crypto/tegra
      7 drivers/crypto/virtio
      2 drivers/crypto/xilinx
      4 drivers/dax
      2 drivers/devfreq
      1 drivers/devfreq/event
     48 drivers/dma
      3 drivers/dma-buf
      1 drivers/dma-buf/heaps
      7 drivers/dma/amd/qdma
      4 drivers/dma/dw
      3 drivers/dma/dw-axi-dmac
      2 drivers/dma/lgm
      3 drivers/dma/mediatek
      5 drivers/dma/qcom
      1 drivers/dma/sf-pdma
      4 drivers/dma/sh
     12 drivers/dma/stm32
     14 drivers/dma/ti
     27 drivers/dma/xilinx
      5 drivers/dpll/zl3073x
     14 drivers/extcon
     11 drivers/firewire
      8 drivers/firmware
     35 drivers/firmware/arm_scmi
     10 drivers/firmware/arm_scmi/transports
      6 drivers/firmware/arm_scmi/vendors/imx
      1 drivers/firmware/cirrus
      2 drivers/firmware/google
      9 drivers/firmware/imx
      1 drivers/firmware/microchip
      2 drivers/firmware/samsung
     11 drivers/fpga
     10 drivers/fsi
      2 drivers/gnss
     47 drivers/gpio
      8 drivers/gpio/pinctrl
      4 drivers/gpu/drm
     12 drivers/gpu/drm/arm
     15 drivers/gpu/drm/arm/display/komeda
      1 drivers/gpu/drm/arm/display/komeda/d71
      2 drivers/gpu/drm/atmel-hlcdc
     40 drivers/gpu/drm/bridge
      9 drivers/gpu/drm/bridge/adv7511
      8 drivers/gpu/drm/bridge/analogix
      9 drivers/gpu/drm/bridge/cadence
      4 drivers/gpu/drm/bridge/imx
     11 drivers/gpu/drm/bridge/synopsys
      1 drivers/gpu/drm/clients
      4 drivers/gpu/drm/display
      5 drivers/gpu/drm/etnaviv
     15 drivers/gpu/drm/exynos
      3 drivers/gpu/drm/gud
      3 drivers/gpu/drm/hisilicon/kirin
      1 drivers/gpu/drm/imx/dc
     11 drivers/gpu/drm/imx/dcss
      2 drivers/gpu/drm/imx/ipuv3
      6 drivers/gpu/drm/ingenic
      9 drivers/gpu/drm/kmb
      4 drivers/gpu/drm/lima
      7 drivers/gpu/drm/logicvc
      2 drivers/gpu/drm/mcde
     39 drivers/gpu/drm/mediatek
     17 drivers/gpu/drm/meson
      2 drivers/gpu/drm/mxsfb
      8 drivers/gpu/drm/omapdrm
     41 drivers/gpu/drm/omapdrm/dss
     41 drivers/gpu/drm/panel
      2 drivers/gpu/drm/pl111
      8 drivers/gpu/drm/renesas/rcar-du
      2 drivers/gpu/drm/renesas/rz-du
     22 drivers/gpu/drm/rockchip
      1 drivers/gpu/drm/scheduler/tests
      4 drivers/gpu/drm/sitronix
      2 drivers/gpu/drm/solomon
      5 drivers/gpu/drm/sprd
     11 drivers/gpu/drm/sti
      3 drivers/gpu/drm/stm
     13 drivers/gpu/drm/sun4i
      1 drivers/gpu/drm/sysfb
     23 drivers/gpu/drm/tegra
     13 drivers/gpu/drm/tests
      1 drivers/gpu/drm/tests/sysfb
     10 drivers/gpu/drm/tidss
      3 drivers/gpu/drm/tiny
      2 drivers/gpu/drm/ttm
      4 drivers/gpu/drm/ttm/tests
      3 drivers/gpu/drm/v3d
      8 drivers/gpu/drm/virtio
      3 drivers/gpu/drm/vkms
      4 drivers/gpu/drm/vkms/tests
      9 drivers/gpu/drm/xlnx
     13 drivers/gpu/host1x
     11 drivers/gpu/host1x/hw
     13 drivers/gpu/ipu-v3
     10 drivers/greybus
    135 drivers/hid
      4 drivers/hid/i2c-hid
      5 drivers/hid/usbhid
      1 drivers/hte
    271 drivers/hwmon
      5 drivers/hwmon/occ
      4 drivers/hwmon/peci
     19 drivers/hwmon/pmbus
      8 drivers/hwtracing/intel_th
      1 drivers/hwtracing/stm
      9 drivers/i2c
    110 drivers/i2c/busses
      4 drivers/i2c/muxes
      1 drivers/i2c/muxes/pinctrl
     15 drivers/i3c/master
      5 drivers/i3c/master/mipi-i3c-hci
      2 drivers/iio
     82 drivers/iio/accel
    248 drivers/iio/adc
      6 drivers/iio/addac
      7 drivers/iio/amplifiers
      2 drivers/iio/cdc
     25 drivers/iio/chemical
      1 drivers/iio/common/cros_ec_sensors
      2 drivers/iio/common/ms_sensors
      5 drivers/iio/common/ssp_sensors
     80 drivers/iio/dac
      2 drivers/iio/dummy
     19 drivers/iio/frequency
     19 drivers/iio/gyro
     11 drivers/iio/humidity
      2 drivers/iio/humidity/common/ms_sensors
     23 drivers/iio/imu
      3 drivers/iio/imu/bmi160
      4 drivers/iio/imu/bmi270
      7 drivers/iio/imu/bmi323
      4 drivers/iio/imu/bno055
      7 drivers/iio/imu/inv_icm42600
      7 drivers/iio/imu/inv_mpu6050
     19 drivers/iio/imu/st_lsm6dsx
     79 drivers/iio/light
     24 drivers/iio/magnetometer
      3 drivers/iio/orientation
      3 drivers/iio/position
     11 drivers/iio/potentiometer
      1 drivers/iio/potentiostat
     34 drivers/iio/pressure
      2 drivers/iio/pressure/common/ms_sensors
     26 drivers/iio/proximity
      9 drivers/iio/resolver
     19 drivers/iio/temperature
      2 drivers/iio/temperature/common/ms_sensors
      2 drivers/iio/trigger
     32 drivers/infiniband/core
     11 drivers/infiniband/sw/siw
      4 drivers/infiniband/ulp/ipoib
      5 drivers/infiniband/ulp/iser
      6 drivers/infiniband/ulp/isert
     11 drivers/infiniband/ulp/rtrs
     10 drivers/infiniband/ulp/srp
      5 drivers/infiniband/ulp/srpt
      8 drivers/input
      1 drivers/input/gameport
     29 drivers/input/joystick
      2 drivers/input/joystick/iforce
     43 drivers/input/keyboard
     57 drivers/input/misc
     42 drivers/input/mouse
     40 drivers/input/rmi4
      8 drivers/input/serio
      5 drivers/input/tablet
    119 drivers/input/touchscreen
      2 drivers/interconnect
      1 drivers/interconnect/imx
      5 drivers/iommu
     15 drivers/iommu/iommufd
      2 drivers/ipack/devices
      6 drivers/irqchip
      9 drivers/isdn/hardware/mISDN
      4 drivers/isdn/mISDN
     56 drivers/leds
      2 drivers/leds/blink
      9 drivers/leds/flash
      9 drivers/leds/rgb
      5 drivers/leds/trigger
     19 drivers/mailbox
     97 drivers/md
     20 drivers/md/bcache
      9 drivers/md/persistent-data
      9 drivers/media/cec/core
      3 drivers/media/cec/i2c
      3 drivers/media/cec/platform/cec-gpio
      3 drivers/media/cec/platform/tegra
      8 drivers/media/cec/usb/extron-da-hd-4k-plus
      4 drivers/media/cec/usb/pulse8
      1 drivers/media/cec/usb/rainshadow
      4 drivers/media/common
      5 drivers/media/common/b2c2
      5 drivers/media/common/siano
      1 drivers/media/common/v4l2-tpg
      4 drivers/media/common/videobuf2
      6 drivers/media/dvb-core
    381 drivers/media/dvb-frontends
     30 drivers/media/dvb-frontends/cxd2880
     55 drivers/media/dvb-frontends/drx39xyj
      3 drivers/media/firewire
    215 drivers/media/i2c
      2 drivers/media/i2c/adv748x
     19 drivers/media/i2c/ccs
      1 drivers/media/i2c/cx25840
      1 drivers/media/i2c/et8ek8
      3 drivers/media/i2c/s5c73m3
      1 drivers/media/mc
      6 drivers/media/platform/allegro-dvt
      2 drivers/media/platform/amlogic/c3/isp
      1 drivers/media/platform/amlogic/c3/mipi-adapter
      1 drivers/media/platform/amlogic/meson-ge2d
      8 drivers/media/platform/amphion
      2 drivers/media/platform/aspeed
      4 drivers/media/platform/atmel
      2 drivers/media/platform/cadence
      7 drivers/media/platform/chips-media/coda
     25 drivers/media/platform/chips-media/wave5
      3 drivers/media/platform/imagination
      2 drivers/media/platform/intel
      2 drivers/media/platform/marvell
      4 drivers/media/platform/mediatek/jpeg
      4 drivers/media/platform/mediatek/mdp
      9 drivers/media/platform/mediatek/mdp3
      5 drivers/media/platform/mediatek/vcodec/common/decoder
      3 drivers/media/platform/mediatek/vcodec/common/encoder
      5 drivers/media/platform/mediatek/vcodec/decoder
     28 drivers/media/platform/mediatek/vcodec/decoder/vdec
      4 drivers/media/platform/mediatek/vcodec/encoder
      6 drivers/media/platform/mediatek/vcodec/encoder/venc
      2 drivers/media/platform/mediatek/vpu
      8 drivers/media/platform/microchip
      1 drivers/media/platform/nuvoton
      2 drivers/media/platform/nvidia/tegra-vde
     11 drivers/media/platform/nxp
      2 drivers/media/platform/nxp/dw100
      5 drivers/media/platform/nxp/imx-jpeg
     20 drivers/media/platform/qcom/camss
      3 drivers/media/platform/qcom/iris
     17 drivers/media/platform/qcom/venus
     11 drivers/media/platform/renesas
      4 drivers/media/platform/renesas/rcar-vin
      8 drivers/media/platform/renesas/rzg2l-cru
     18 drivers/media/platform/renesas/vsp1
      1 drivers/media/platform/rockchip/rga
      5 drivers/media/platform/rockchip/rkisp1
      5 drivers/media/platform/rockchip/rkvdec
      5 drivers/media/platform/samsung/exynos-gsc
     25 drivers/media/platform/samsung/exynos4-is
      3 drivers/media/platform/samsung/s5p-jpeg
     25 drivers/media/platform/samsung/s5p-mfc
      7 drivers/media/platform/st/sti/bdisp
      1 drivers/media/platform/st/sti/c8sectpfe
      5 drivers/media/platform/st/sti/delta
      8 drivers/media/platform/st/sti/hva
      5 drivers/media/platform/st/stm32
      1 drivers/media/platform/st/stm32/dma2d
      5 drivers/media/platform/st/stm32/stm32-dcmipp
      2 drivers/media/platform/sunxi/sun4i-csi
      3 drivers/media/platform/synopsys/hdmirx
      1 drivers/media/platform/ti/am437x
      2 drivers/media/platform/ti/cal
      5 drivers/media/platform/ti/davinci
      1 drivers/media/platform/ti/j721e-csi2rx
      3 drivers/media/platform/ti/omap
     31 drivers/media/platform/ti/omap3isp
      6 drivers/media/platform/ti/vpe
     10 drivers/media/platform/verisilicon
      5 drivers/media/platform/xilinx
     16 drivers/media/radio
      2 drivers/media/radio/si470x
     56 drivers/media/rc
      5 drivers/media/rc/img-ir
      4 drivers/media/spi
      2 drivers/media/test-drivers
      1 drivers/media/test-drivers/vicodec
     28 drivers/media/test-drivers/vidtv
      3 drivers/media/test-drivers/vimc
     27 drivers/media/test-drivers/vivid
     93 drivers/media/tuners
      2 drivers/media/usb/as102
      6 drivers/media/usb/au0828
      1 drivers/media/usb/b2c2
     28 drivers/media/usb/cx231xx
     24 drivers/media/usb/dvb-usb
     34 drivers/media/usb/dvb-usb-v2
     22 drivers/media/usb/em28xx
      5 drivers/media/usb/go7007
     53 drivers/media/usb/gspca
      3 drivers/media/usb/gspca/gl860
      2 drivers/media/usb/gspca/m5602
      4 drivers/media/usb/gspca/stv06xx
      6 drivers/media/usb/hdpvr
      1 drivers/media/usb/msi2500
      7 drivers/media/usb/pvrusb2
      7 drivers/media/usb/pwc
      2 drivers/media/usb/s2255
      1 drivers/media/usb/siano
      1 drivers/media/usb/stk1160
     28 drivers/media/usb/uvc
      1 drivers/media/v4l2-core
     12 drivers/memory
      1 drivers/memory/samsung
      6 drivers/memory/tegra
     13 drivers/memstick/core
      2 drivers/memstick/host
     18 drivers/mfd
     23 drivers/misc
      2 drivers/misc/altera-stapl
      1 drivers/misc/amd-sbi
      7 drivers/misc/eeprom
      2 drivers/misc/lis3lv02d
      2 drivers/misc/lkdtm
      8 drivers/mmc/core
     97 drivers/mmc/host
      7 drivers/most
      6 drivers/mtd
      1 drivers/mtd/chips
     12 drivers/mtd/devices
      1 drivers/mtd/maps
      1 drivers/mtd/nand
     34 drivers/mtd/nand/raw
      3 drivers/mtd/nand/raw/atmel
      2 drivers/mtd/nand/raw/brcmnand
      4 drivers/mtd/nand/raw/gpmi-nand
      2 drivers/mtd/nand/raw/ingenic
      1 drivers/mtd/parsers
      8 drivers/mtd/spi-nor
      1 drivers/mtd/spi-nor/controllers
      9 drivers/mtd/ubi
     37 drivers/net
      3 drivers/net/arcnet
      1 drivers/net/bonding
      3 drivers/net/caif
      7 drivers/net/can
      2 drivers/net/can/c_can
      1 drivers/net/can/cc770
      2 drivers/net/can/flexcan
      7 drivers/net/can/m_can
      3 drivers/net/can/rcar
      2 drivers/net/can/slcan
      1 drivers/net/can/softing
      3 drivers/net/can/spi
     12 drivers/net/can/spi/mcp251xfd
     12 drivers/net/can/usb
      2 drivers/net/can/usb/etas_es58x
      6 drivers/net/can/usb/kvaser_usb
      4 drivers/net/can/usb/peak_usb
     14 drivers/net/dsa
     13 drivers/net/dsa/b53
      5 drivers/net/dsa/hirschmann
     17 drivers/net/dsa/microchip
     20 drivers/net/dsa/mv88e6xxx
      1 drivers/net/dsa/ocelot
      6 drivers/net/dsa/qca
      6 drivers/net/dsa/realtek
     13 drivers/net/dsa/sja1105
      3 drivers/net/ethernet
      1 drivers/net/ethernet/3com
     10 drivers/net/ethernet/8390
      3 drivers/net/ethernet/adi
      5 drivers/net/ethernet/airoha
      5 drivers/net/ethernet/amd
      5 drivers/net/ethernet/amd/xgbe
     18 drivers/net/ethernet/apm/xgene
      2 drivers/net/ethernet/apm/xgene-v2
      1 drivers/net/ethernet/arc
      3 drivers/net/ethernet/asix
      5 drivers/net/ethernet/atheros
     14 drivers/net/ethernet/broadcom
      5 drivers/net/ethernet/broadcom/asp2
     11 drivers/net/ethernet/broadcom/genet
      4 drivers/net/ethernet/cadence
      2 drivers/net/ethernet/calxeda
      3 drivers/net/ethernet/cirrus
      3 drivers/net/ethernet/cortina
      4 drivers/net/ethernet/davicom
     11 drivers/net/ethernet/engleder
      2 drivers/net/ethernet/faraday
     16 drivers/net/ethernet/freescale
      9 drivers/net/ethernet/freescale/enetc
     58 drivers/net/ethernet/freescale/fman
      3 drivers/net/ethernet/fujitsu
      1 drivers/net/ethernet/hisilicon
     16 drivers/net/ethernet/hisilicon/hns
      1 drivers/net/ethernet/i825xx
     10 drivers/net/ethernet/marvell
     17 drivers/net/ethernet/marvell/mvpp2
     52 drivers/net/ethernet/marvell/prestera
     25 drivers/net/ethernet/mediatek
      2 drivers/net/ethernet/mellanox/mlxbf_gige
      4 drivers/net/ethernet/mellanox/mlxfw
     51 drivers/net/ethernet/mellanox/mlxsw
      1 drivers/net/ethernet/mellanox/mlxsw/mlxfw
      7 drivers/net/ethernet/micrel
      4 drivers/net/ethernet/microchip
     23 drivers/net/ethernet/microchip/lan966x
     30 drivers/net/ethernet/microchip/sparx5
     26 drivers/net/ethernet/microchip/sparx5/lan969x
      6 drivers/net/ethernet/microchip/vcap
     22 drivers/net/ethernet/microchip/vcap/sparx5
      6 drivers/net/ethernet/mscc
      1 drivers/net/ethernet/ni
      4 drivers/net/ethernet/qualcomm
      4 drivers/net/ethernet/qualcomm/emac
      4 drivers/net/ethernet/qualcomm/rmnet
     14 drivers/net/ethernet/renesas
      5 drivers/net/ethernet/samsung/sxgbe
      3 drivers/net/ethernet/smsc
      6 drivers/net/ethernet/socionext
     40 drivers/net/ethernet/stmicro/stmmac
      3 drivers/net/ethernet/sunplus
      3 drivers/net/ethernet/synopsys
      4 drivers/net/ethernet/vertexcom
      5 drivers/net/ethernet/via
      8 drivers/net/ethernet/wiznet
     10 drivers/net/ethernet/xilinx
     11 drivers/net/hamradio
     34 drivers/net/ieee802154
     32 drivers/net/ipa
      6 drivers/net/ipa/data
      1 drivers/net/ipvlan
      8 drivers/net/mctp
      4 drivers/net/mdio
     21 drivers/net/netdevsim
      5 drivers/net/ovpn
      3 drivers/net/pcs
     58 drivers/net/phy
     14 drivers/net/phy/mscc
      4 drivers/net/phy/qcom
      1 drivers/net/phy/realtek
      2 drivers/net/plip
      6 drivers/net/ppp
      3 drivers/net/pse-pd
      2 drivers/net/slip
      1 drivers/net/team
     34 drivers/net/usb
      7 drivers/net/vxlan
     13 drivers/net/wan
      2 drivers/net/wan/framer/pef2256
      7 drivers/net/wireguard
      2 drivers/net/wireguard/selftest
      9 drivers/net/wireless/ath
    148 drivers/net/wireless/ath/ath10k
    173 drivers/net/wireless/ath/ath11k
     61 drivers/net/wireless/ath/ath6kl
    100 drivers/net/wireless/ath/ath9k
     28 drivers/net/wireless/ath/carl9170
     53 drivers/net/wireless/ath/wcn36xx
      8 drivers/net/wireless/atmel
     70 drivers/net/wireless/broadcom/b43
     27 drivers/net/wireless/broadcom/b43legacy
     74 drivers/net/wireless/broadcom/brcm80211/brcmfmac
     44 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca
      2 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/include
     45 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw
      2 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/include
      3 drivers/net/wireless/broadcom/brcm80211/brcmfmac/include
     44 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc
      2 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/include
     39 drivers/net/wireless/broadcom/brcm80211/brcmsmac
      1 drivers/net/wireless/broadcom/brcm80211/brcmsmac/include
     64 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy
      3 drivers/net/wireless/broadcom/brcm80211/brcmutil/include
      7 drivers/net/wireless/intersil/p54
     22 drivers/net/wireless/marvell/libertas
      9 drivers/net/wireless/marvell/libertas_tf
    147 drivers/net/wireless/marvell/mwifiex
     69 drivers/net/wireless/mediatek/mt76
     59 drivers/net/wireless/mediatek/mt76/mt7615
     61 drivers/net/wireless/mediatek/mt76/mt76x0
     57 drivers/net/wireless/mediatek/mt76/mt76x2
     50 drivers/net/wireless/mediatek/mt76/mt7921
     51 drivers/net/wireless/mediatek/mt76/mt7925
     10 drivers/net/wireless/mediatek/mt7601u
     34 drivers/net/wireless/microchip/wilc1000
     10 drivers/net/wireless/purelifi/plfxlc
     14 drivers/net/wireless/ralink/rt2x00
      5 drivers/net/wireless/realtek/rtl818x/rtl8187
     25 drivers/net/wireless/realtek/rtl8xxxu
    106 drivers/net/wireless/realtek/rtlwifi
     59 drivers/net/wireless/realtek/rtlwifi/btcoexist
    102 drivers/net/wireless/realtek/rtlwifi/rtl8192c
      1 drivers/net/wireless/realtek/rtlwifi/rtl8192c/rtl8192ce
    104 drivers/net/wireless/realtek/rtlwifi/rtl8192cu
      2 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192c
      1 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192ce
    102 drivers/net/wireless/realtek/rtlwifi/rtl8192d
     97 drivers/net/wireless/realtek/rtlwifi/rtl8192du
      1 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rtl8192d
     90 drivers/net/wireless/realtek/rtw88
    224 drivers/net/wireless/realtek/rtw89
     33 drivers/net/wireless/rsi
     11 drivers/net/wireless/silabs/wfx
     31 drivers/net/wireless/st/cw1200
     11 drivers/net/wireless/ti/wl1251
      2 drivers/net/wireless/ti/wl12xx
     36 drivers/net/wireless/ti/wl12xx/wlcore
      4 drivers/net/wireless/ti/wl18xx
     36 drivers/net/wireless/ti/wl18xx/wlcore
     40 drivers/net/wireless/ti/wlcore
     13 drivers/net/wireless/virtual
     11 drivers/net/wireless/zydas/zd1211rw
      2 drivers/net/wwan
     15 drivers/nfc
      3 drivers/nfc/fdp
      3 drivers/nfc/nfcmrvl
      1 drivers/nfc/nxp-nci
      5 drivers/nfc/pn533
      2 drivers/nfc/pn544
      4 drivers/nfc/s3fwrn5
      9 drivers/nfc/st-nci
      6 drivers/nfc/st21nfca
      5 drivers/nfc/st95hf
      2 drivers/nvme/common
     33 drivers/nvme/host
     36 drivers/nvme/target
     16 drivers/nvme/target/host
     22 drivers/nvme/target/target
      7 drivers/nvmem
      3 drivers/of
      3 drivers/opp
      5 drivers/pci
      2 drivers/pcmcia
      1 drivers/phy
      5 drivers/phy/allwinner
      1 drivers/phy/amlogic
      6 drivers/phy/broadcom
      9 drivers/phy/cadence
      5 drivers/phy/freescale
      2 drivers/phy/marvell
      8 drivers/phy/mediatek
      3 drivers/phy/microchip
      2 drivers/phy/motorola
      2 drivers/phy/mscc
     16 drivers/phy/qualcomm
      1 drivers/phy/ralink
      6 drivers/phy/realtek
      2 drivers/phy/renesas
     19 drivers/phy/rockchip
      4 drivers/phy/samsung
      6 drivers/phy/socionext
      4 drivers/phy/st
      1 drivers/phy/tegra
      7 drivers/phy/ti
      2 drivers/phy/xilinx
     24 drivers/pinctrl
      2 drivers/pinctrl/actions
      8 drivers/pinctrl/bcm
      3 drivers/pinctrl/berlin
      1 drivers/pinctrl/cirrus
      6 drivers/pinctrl/freescale
     21 drivers/pinctrl/mediatek
      1 drivers/pinctrl/meson
      1 drivers/pinctrl/nomadik
      2 drivers/pinctrl/nuvoton
      1 drivers/pinctrl/pxa
      9 drivers/pinctrl/qcom
      7 drivers/pinctrl/renesas
      6 drivers/pinctrl/samsung
      5 drivers/pinctrl/sophgo
      4 drivers/pinctrl/spacemit
      1 drivers/pinctrl/sprd
      1 drivers/pinctrl/starfive
      5 drivers/pinctrl/stm32
      2 drivers/pinctrl/ti
      1 drivers/pinctrl/uniphier
      1 drivers/pinctrl/visconti
      2 drivers/platform/arm64
     16 drivers/platform/chrome
      7 drivers/platform/cznic
      2 drivers/platform/mellanox
      6 drivers/platform/olpc
      3 drivers/pnp
      3 drivers/pnp/isapnp
      2 drivers/power/reset
      1 drivers/power/sequencing
     74 drivers/power/supply
      1 drivers/powercap
      1 drivers/pps/clients
     13 drivers/ptp
     21 drivers/pwm
     43 drivers/regulator
      7 drivers/remoteproc
      5 drivers/reset
      1 drivers/reset/amlogic
      2 drivers/reset/sti
      7 drivers/rpmsg
     52 drivers/rtc
     43 drivers/scsi
      3 drivers/scsi/device_handler
      4 drivers/scsi/hisi_sas
      2 drivers/scsi/libfc
      5 drivers/scsi/pcmcia
      2 drivers/siox
      3 drivers/slimbus
      1 drivers/soc/amlogic
      3 drivers/soc/aspeed
      4 drivers/soc/fsl/qe
      3 drivers/soc/loongson
     12 drivers/soc/mediatek
      1 drivers/soc/nuvoton
     25 drivers/soc/qcom
      2 drivers/soc/samsung
      4 drivers/soc/sunxi
      4 drivers/soundwire
    122 drivers/spi
      4 drivers/spmi
      3 drivers/ssb
      6 drivers/staging/fbtft
      3 drivers/staging/gpib/agilent_82357a
      1 drivers/staging/gpib/cb7210
      1 drivers/staging/gpib/gpio
     14 drivers/staging/gpib/include
      1 drivers/staging/gpib/ines
      3 drivers/staging/gpib/lpvo_usb_gpib
      4 drivers/staging/gpib/ni_usb
     34 drivers/staging/greybus
      1 drivers/staging/iio/adc
      1 drivers/staging/iio/addac
      4 drivers/staging/iio/frequency
      2 drivers/staging/iio/impedance-analyzer
      7 drivers/staging/media/deprecated/atmel
     10 drivers/staging/media/imx
      2 drivers/staging/media/max96712
      4 drivers/staging/media/meson/vdec
      4 drivers/staging/media/tegra-video
     11 drivers/staging/most/dim2
      1 drivers/staging/most/i2c
      2 drivers/staging/most/net
      1 drivers/staging/most/video
      2 drivers/staging/octeon
     63 drivers/staging/rtl8723bs/hal
    138 drivers/staging/rtl8723bs/include
      1 drivers/staging/vc04_services/bcm2835-audio
      4 drivers/staging/vc04_services/bcm2835-audio/interface/vchiq_arm
      1 drivers/staging/vc04_services/bcm2835-camera
      3 drivers/staging/vc04_services/bcm2835-camera/vchiq-mmal
      4 drivers/staging/vc04_services/interface/vchiq_arm
      3 drivers/staging/vc04_services/vchiq-mmal
      4 drivers/staging/vc04_services/vchiq-mmal/interface/vchiq_arm
     14 drivers/target
      5 drivers/target/iscsi
      1 drivers/target/loopback
      3 drivers/target/sbp
      2 drivers/target/tcm_fc
      2 drivers/target/tcm_remote
      1 drivers/tee
      9 drivers/thermal
      4 drivers/thermal/mediatek
      4 drivers/thermal/qcom
      1 drivers/thermal/renesas
      2 drivers/thermal/samsung
     11 drivers/thermal/tegra
      2 drivers/thermal/ti-soc-thermal
     16 drivers/tty
      7 drivers/tty/ipwireless
     59 drivers/tty/serial
     16 drivers/tty/serial/8250
      2 drivers/ufs/core
      3 drivers/ufs/host
      6 drivers/usb/atm
      3 drivers/usb/c67x00
     10 drivers/usb/cdns3
     11 drivers/usb/cdns3/host
      9 drivers/usb/chipidea
     14 drivers/usb/chipidea/host
     10 drivers/usb/class
      1 drivers/usb/common
      6 drivers/usb/core
      1 drivers/usb/core/misc
     35 drivers/usb/dwc2
     19 drivers/usb/dwc3
      1 drivers/usb/dwc3/host
     12 drivers/usb/fotg210
      3 drivers/usb/gadget
    103 drivers/usb/gadget/function
      6 drivers/usb/gadget/legacy
     49 drivers/usb/gadget/udc
      8 drivers/usb/gadget/udc/aspeed-vhub
      4 drivers/usb/gadget/udc/bdc
     75 drivers/usb/host
      1 drivers/usb/image
      6 drivers/usb/isp1760
     30 drivers/usb/misc
     10 drivers/usb/misc/sisusbvga
      2 drivers/usb/mon
      7 drivers/usb/mtu3
     28 drivers/usb/musb
      2 drivers/usb/phy
      3 drivers/usb/renesas_usbhs
      2 drivers/usb/roles
     66 drivers/usb/serial
     23 drivers/usb/storage
      1 drivers/usb/storage/scsi
     12 drivers/usb/typec
      2 drivers/usb/typec/altmodes
      4 drivers/usb/typec/mux
     17 drivers/usb/typec/tcpm
      2 drivers/usb/typec/tcpm/qcom
      2 drivers/usb/typec/tipd
     10 drivers/usb/usbip
      3 drivers/vdpa/vdpa_sim
      2 drivers/vfio
      1 drivers/vfio/cdx
      2 drivers/vfio/platform
      2 drivers/vfio/platform/reset
     12 drivers/vhost
     20 drivers/video/backlight
     25 drivers/video/fbdev
      6 drivers/video/fbdev/aty
      5 drivers/video/fbdev/core
      1 drivers/virt/coco/guest
     19 drivers/virtio
      1 drivers/w1
      6 drivers/w1/masters
      4 drivers/w1/slaves
     34 drivers/watchdog
     18 fs
      1 fs/9p
      2 fs/adfs
      1 fs/affs
     33 fs/afs
      1 fs/autofs
    150 fs/bcachefs
     74 fs/btrfs
     47 fs/btrfs/tests
      3 fs/cachefiles
     24 fs/ceph
      2 fs/coda
      3 fs/configfs
      5 fs/crypto
      1 fs/debugfs
     10 fs/dlm
      9 fs/ecryptfs
      1 fs/efs
     17 fs/erofs
      9 fs/exfat
     18 fs/ext4
     27 fs/f2fs
     11 fs/fat
      4 fs/freevxfs
     15 fs/fuse
      4 fs/gfs2
      4 fs/hfs
      4 fs/hfsplus
      4 fs/hpfs
      3 fs/iomap
      3 fs/isofs
      8 fs/jffs2
     12 fs/jfs
      1 fs/lockd
      1 fs/minix
      6 fs/mm
      1 fs/netfs
     22 fs/nfs
      8 fs/nfs/blocklayout
      6 fs/nfs/filelayout
      8 fs/nfs/flexfilelayout
      1 fs/nfs_common/nfs
     48 fs/nfsd
      1 fs/nilfs2
      2 fs/notify/fanotify
     17 fs/ntfs3
      1 fs/ntfs3/lib
     18 fs/ocfs2
     10 fs/ocfs2/cluster
     11 fs/ocfs2/dlm
      4 fs/ocfs2/dlm/cluster
      6 fs/ocfs2/dlmfs
      6 fs/orangefs
     18 fs/overlayfs
      4 fs/proc
      2 fs/pstore
      1 fs/qnx6
      4 fs/quota
     69 fs/smb/client
      2 fs/smb/client/common/smbdirect
     24 fs/smb/server
     19 fs/smb/server/mgmt
      3 fs/smb/server/mgmt/mgmt
      2 fs/squashfs
     22 fs/ubifs
      7 fs/udf
      5 fs/ufs
      1 fs/verity
     18 fs/xfs
     31 fs/xfs/libxfs
     32 fs/xfs/scrub
      3 fs/zonefs
     10 include/acpi
      2 include/asm-generic
      1 include/clocksource
     37 include/crypto
     10 include/crypto/internal
     59 include/drm
      9 include/drm/bridge
     39 include/drm/display
     10 include/drm/ttm
      8 include/keys
      3 include/kunit
    910 include/linux
      5 include/linux/amba
     14 include/linux/bcma
      3 include/linux/can
      3 include/linux/can/platform
      9 include/linux/cdx
     32 include/linux/ceph
      4 include/linux/clk
      3 include/linux/comedi
      2 include/linux/crush
      2 include/linux/device
      5 include/linux/dma
      5 include/linux/dsa
      1 include/linux/extcon
      5 include/linux/firmware/cirrus
      1 include/linux/fpga
      1 include/linux/framer
     11 include/linux/fsl
      7 include/linux/gpio
     10 include/linux/greybus
      3 include/linux/hsi
      9 include/linux/i3c
     11 include/linux/iio
      1 include/linux/iio/accel
      5 include/linux/iio/adc
      1 include/linux/iio/afe
     14 include/linux/iio/common
      2 include/linux/iio/dac
      5 include/linux/iio/frequency
      4 include/linux/iio/imu
      3 include/linux/input
      8 include/linux/lockd
      1 include/linux/mdio
     44 include/linux/mfd
      1 include/linux/mfd/abx500
     10 include/linux/mfd/arizona
      1 include/linux/mfd/da9052
      2 include/linux/mfd/da9063
      1 include/linux/mfd/da9150
      2 include/linux/mfd/madera
      1 include/linux/mfd/mt6358
      5 include/linux/mfd/samsung
      5 include/linux/mfd/wm831x
      7 include/linux/mfd/wm8994
     38 include/linux/mmc
     40 include/linux/mtd
     13 include/linux/netfilter
      6 include/linux/netfilter/ipset
      1 include/linux/netfilter_arp
      4 include/linux/netfilter_bridge
      1 include/linux/netfilter_ipv4
      3 include/linux/phy
      4 include/linux/pinctrl
     87 include/linux/platform_data
      1 include/linux/platform_data/txx9
      1 include/linux/platform_data/x86
      8 include/linux/power
      3 include/linux/pse-pd
     18 include/linux/regulator
      1 include/linux/remoteproc
      1 include/linux/reset
      2 include/linux/rtc
      4 include/linux/sched
      9 include/linux/soc/mediatek
      4 include/linux/soc/qcom
      8 include/linux/soc/ti
     13 include/linux/soundwire
     26 include/linux/spi
     16 include/linux/ssb
     17 include/linux/sunrpc
     82 include/linux/usb
     69 include/media
      2 include/media/davinci
      9 include/media/drv-intf
     24 include/media/i2c
      7 include/media/tpg
      7 include/memory
    627 include/net
     10 include/net/9p
     90 include/net/bluetooth
      5 include/net/caif
      6 include/net/libeth
     64 include/net/netfilter
     15 include/net/netfilter/../net/bridge
     15 include/net/netns
     20 include/net/nfc
      1 include/net/page_pool
      1 include/net/phonet
     40 include/net/sctp
     36 include/net/tc_act
     29 include/pcmcia
    101 include/rdma
     89 include/scsi
      2 include/soc/at91
      7 include/soc/fsl/qe
      2 include/soc/microchip
     17 include/soc/mscc
      5 include/soc/tegra
    162 include/sound
     31 include/target
     32 include/target/iscsi
      1 include/tools/lib/bpf
      6 include/trace/events/../fs/dlm
     15 include/trace/events/../net/bridge
     17 include/trace/events/../sound/soc/sof
      1 include/uapi/asm-generic
      2 include/uapi/drm
    216 include/uapi/linux
      1 include/uapi/linux/caif
      2 include/uapi/linux/can
      4 include/uapi/linux/dvb
      3 include/uapi/linux/hdlc
     58 include/uapi/linux/netfilter
      2 include/uapi/linux/netfilter/ipset
      3 include/uapi/linux/netfilter_arp
      6 include/uapi/linux/netfilter_bridge
      2 include/uapi/linux/netfilter_ipv4
      5 include/uapi/linux/netfilter_ipv6
      3 include/uapi/linux/tc_act
      2 include/uapi/linux/usb
      3 include/uapi/misc
      1 include/uapi/mtd
      2 include/uapi/rdma
      1 include/uapi/rdma/hfi
      1 include/uapi/scsi
     11 include/uapi/sound
      1 include/uapi/video
     28 include/ufs
     32 include/video
      2 init
     22 io_uring
      1 io_uring/fs
      1 io_uring/kernel/futex
      2 ipc
     23 kernel
     35 kernel/bpf
      4 kernel/bpf/cgroup
      1 kernel/bpf/tools/lib/bpf
      6 kernel/cgroup
      1 kernel/dma
      3 kernel/futex
      2 kernel/irq
      5 kernel/locking
      6 kernel/mm
      2 kernel/module
      1 kernel/printk
      4 kernel/rcu
     13 kernel/sched
      9 kernel/time
     30 lib
      5 lib/842
      1 lib/crc/tests
      1 lib/crypto
      1 lib/crypto/tests
      4 lib/kunit
      6 lib/mm
     14 lib/tests
      5 lib/xz
      3 lib/zlib_deflate
      4 lib/zstd/compress
      1 lib/zstd/decompress
     32 mm
      9 mm/damon
      2 net/6lowpan
      2 net/8021q
      6 net/9p
      7 net/atm
     15 net/atm/bridge
      1 net/ax25
     41 net/batman-adv
     28 net/bluetooth
      4 net/bluetooth/bnep
      4 net/bluetooth/hidp
      1 net/bluetooth/rfcomm
      1 net/bpf
     31 net/bridge
     15 net/bridge/netfilter
      8 net/caif
      3 net/can
      3 net/can/j1939
      5 net/ceph
     16 net/core
      8 net/devlink
      8 net/dsa
     16 net/ethtool
      1 net/ethtool/core
      1 net/handshake
      4 net/hsr
      1 net/ieee802154
     23 net/ipv4
      6 net/ipv6
     15 net/ipv6/bridge
      3 net/ipv6/ila
      1 net/key
      5 net/l2tp
    116 net/mac80211
    102 net/mac80211/tests
      3 net/mac802154
      4 net/mpls
     15 net/mptcp
     33 net/ncsi
     44 net/netfilter
     15 net/netfilter/bridge
     11 net/netfilter/ipset
      2 net/netfilter/ipvs
      1 net/netlabel
      3 net/netlink
     11 net/nfc
      6 net/nfc/hci
      4 net/nfc/nci
     11 net/openvswitch
      1 net/packet
      1 net/qrtr
     19 net/rds
      4 net/rfkill
     38 net/rxrpc
     53 net/sched
      2 net/sctp
      1 net/shaper/core
     38 net/smc
      5 net/sunrpc
      1 net/sunrpc/auth_gss
     37 net/tipc
      4 net/tls
      2 net/unix
      4 net/vmw_vsock
     24 net/wireless
     15 net/wireless/tests
     97 net/wireless/tests/mac80211
     10 net/xfrm
      6 samples/vfio-mdev
      6 security/apparmor/include
      3 security/integrity/evm
      1 security/integrity/ima
      1 security/keys
      7 security/landlock
      4 security/selinux
     12 security/selinux/include
     10 security/selinux/ss
     36 security/tomoyo
      1 security/yama
      3 sound/core
      3 sound/core/oss
      8 sound/core/seq
      9 sound/core/seq/oss
      9 sound/drivers
      1 sound/drivers/vx
      9 sound/firewire
      8 sound/firewire/bebob
      7 sound/firewire/bebob/.
      9 sound/firewire/dice
      8 sound/firewire/digi00x
      9 sound/firewire/fireface
      9 sound/firewire/fireface/.
      8 sound/firewire/fireworks
      8 sound/firewire/fireworks/.
      9 sound/firewire/motu
      8 sound/firewire/motu/.
     16 sound/firewire/oxfw
      9 sound/firewire/oxfw/.
     11 sound/firewire/tascam
     11 sound/firewire/tascam/.
     31 sound/hda/codecs
     14 sound/hda/codecs/cirrus
     18 sound/hda/codecs/common
      7 sound/hda/codecs/hdmi
     15 sound/hda/codecs/realtek
      2 sound/hda/codecs/realtek/side-codecs
      2 sound/hda/codecs/side-codecs
     19 sound/hda/common
      2 sound/hda/core
      2 sound/pci/ac97
      2 sound/pcmcia/pdaudiocf
      1 sound/soc/adi
      2 sound/soc/amd
     18 sound/soc/amd/sof/amd
      2 sound/soc/apple
      5 sound/soc/atmel
      1 sound/soc/atmel/codecs
      2 sound/soc/bcm
    335 sound/soc/codecs
      3 sound/soc/codecs/aw88395
      2 sound/soc/dwc
     25 sound/soc/fsl
      6 sound/soc/fsl/codecs
      1 sound/soc/generic
      1 sound/soc/hisilicon
      4 sound/soc/img
      3 sound/soc/intel/boards/codecs
      3 sound/soc/intel/keembay
      1 sound/soc/jz4740
      5 sound/soc/mediatek/common
      5 sound/soc/mediatek/mt8186
      3 sound/soc/mediatek/mt8186/codecs
      3 sound/soc/mediatek/mt8186/common
      5 sound/soc/mediatek/mt8188
      5 sound/soc/mediatek/mt8188/codecs
      3 sound/soc/mediatek/mt8188/common
      4 sound/soc/mediatek/mt8195
      1 sound/soc/mediatek/mt8195/codecs
      3 sound/soc/mediatek/mt8195/common
      9 sound/soc/mediatek/mt8365
      3 sound/soc/mediatek/mt8365/common
      2 sound/soc/meson
     10 sound/soc/qcom
      1 sound/soc/qcom/codecs
     17 sound/soc/qcom/qdsp6
      2 sound/soc/renesas
      1 sound/soc/renesas/rcar
      4 sound/soc/rockchip
      2 sound/soc/rockchip/codecs
      3 sound/soc/samsung
     12 sound/soc/samsung/codecs
     19 sound/soc/sof
     14 sound/soc/sof/imx
     17 sound/soc/sof/intel
     17 sound/soc/sof/mediatek
     17 sound/soc/sof/mediatek/mt8186
     17 sound/soc/sof/mediatek/mt8195
     11 sound/soc/sof/xtensa
      2 sound/soc/sprd
      4 sound/soc/starfive
      4 sound/soc/stm
      5 sound/soc/sunxi
      2 sound/soc/tegra
     16 sound/soc/ti
      2 sound/soc/uniphier
     10 sound/soc/usb
      4 sound/soc/xilinx
      1 sound/spi
     43 sound/usb
     10 sound/usb/6fire
      7 sound/usb/caiaq
      5 sound/usb/hiface
      3 sound/usb/line6
      5 sound/usb/misc
     44 sound/usb/qcom
      5 sound/usb/usx2y
      1 sound/virtio


