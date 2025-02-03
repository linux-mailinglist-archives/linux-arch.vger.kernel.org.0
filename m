Return-Path: <linux-arch+bounces-9967-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8273CA2585E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 12:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C2D3A5F53
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 11:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118F202F9E;
	Mon,  3 Feb 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Vg46NJjH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yuRmUb4A"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287A1DF27D;
	Mon,  3 Feb 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738583027; cv=none; b=o6uWMu0l5XTYhLSXAzY63SUjqvmEHVzQfIQq6e1rVZEk1QTBeG11cE7kQ7Cc5l0MKpVdU6DiW2RnDNEp0WNB/LwoimDI/+NJN7GagbzzAuFh3K3ITfoYLZtuIEDfpmXAUXw0jUGQHz7WIbBh9X6CFUNLnzzx72wnoz8IGx6AdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738583027; c=relaxed/simple;
	bh=KoR2qOJvTrWLWPSQe+xMHlxveCMgAyObFDSO11iVdag=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XjiaytluHdzfcUS8fLxI43ABkTwqPdEiq4IOMNCQB/NW+txI+/jUbSvvuI6HnEN5DEIxxfF9eg8k7NmbchBXN/DPFZTSfAqrkMq08xKSiLiRaTtsU5EAFRJ+byr3PqOcX7pC1ziWVQo6cAQ8NZwvOy28yAZPk9lgaaFv0JItGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Vg46NJjH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yuRmUb4A; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1ADA11400B1;
	Mon,  3 Feb 2025 06:43:43 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 06:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738583023;
	 x=1738669423; bh=xqhqW5gqTtDYnBOA3l3UAKIyXJXtbnGDKov4aqYJRdg=; b=
	Vg46NJjHLHL+2uVwH2obvxIxiIoTJuwaVLqtGjOX+TnNdjaYqCYCBHTRKRVmdgDA
	ASLNFGSfeP2vq/t53nGxFe1P2WPQwajYyD2l6UTOPYRNT3PWX/TBl+00YOK1+oee
	x7OUU75RZlKVGbhgh8GTWuDGt3j+VB6gJfjacwRtwqi2PIu9TfnAWRf7wmBhM1BD
	iho4emCg3YyBY7TiDomlVzwVX0C3vTJrdpRO4GbC/NuxZP8t0yzq0QNNWESX3P5l
	TLaS+3cE7PByahDBHzj4eNO88lfd6YYgbnJgEhdfyQPHUbeu3djtqPkhQc0sx7Oi
	+meqonqq1DKoEynpRdR1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738583023; x=
	1738669423; bh=xqhqW5gqTtDYnBOA3l3UAKIyXJXtbnGDKov4aqYJRdg=; b=y
	uRmUb4AeDL0gA5Qic0C1n4mGEQu/TgvHlMiX0MtaDyPBylNjEptGDIjWKhgNTwle
	RTBiKW1t1qnYUxMoyqc2AbkrmqSLi053SDIvXtadCoJw2lg/mWSJWCWRhqKu5Sez
	lIo+oQEKNjFdhQ2GwTrozlp8SSzOF/h8L0Nb4nV3w73Urp5DoFBl7K21NhhItW3z
	7yHwUrk87glvI5JVaeKKSdQ44HPTopcT2wSEQxmI6C+WVmYM2yOrXZ4wUq2GwLl2
	v6I1gcTbrXo3OFbiROCHZmnc8amwds+idxfxJ6a1HYxOR/rpc9LWr78P7S9kf+5S
	AP2Ydaxe+azrSLLncOriw==
X-ME-Sender: <xms:76ugZy5erm3z9pmvUpFmmCG5ifrOHhHL6qe4wUFZ7yaiW5mUnzZvEw>
    <xme:76ugZ76JOVp7eTZgTJkJblKK7MecOHiX52Tgy0pUJGafZiFxWiImlVnDBl3lJZTQd
    EheCawOfcnDmIUs5IM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrd
    horhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehprghlmhgvrhesrhhivhhoshhinhgtrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:76ugZxeyyNIKoCDpKGMHpl3Uz6cCFDME61l8FPQPqm9qDXLKeo4PHQ>
    <xmx:76ugZ_Lpi3O816d0T96KAl-Tf0vWwKiDFOUp3qS2V7liysxk0nX2gQ>
    <xmx:76ugZ2LMHarauIloBEUU3Q2xA3BBT5L-VDtGy4lNqJrikZZQxC1ggA>
    <xmx:76ugZwyujhvkcm-LxxFsWIKd0_EgmJlXoMx13AWjWC0N5olzqHxa1Q>
    <xmx:76ugZ--qR8406x2GRTqcCBSFAppoch57mk_LS3rIWMIR3grzc0TjF0Cj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 16FE82220072; Mon,  3 Feb 2025 06:43:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 12:43:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Kees Cook" <kees@kernel.org>, "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Message-Id: <4d4ac954-16c4-4c85-995d-c7bb1e15b0ce@app.fastmail.com>
In-Reply-To: 
 <20250203092335-3cb21dd4-5276-4ac5-bd8d-7db6662f18f5@linutronix.de>
References: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
 <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>
 <20250203092335-3cb21dd4-5276-4ac5-bd8d-7db6662f18f5@linutronix.de>
Subject: Re: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025, at 09:25, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Feb 03, 2025 at 09:18:33AM +0100, Arnd Bergmann wrote:
>> I have not tried it yet, but I suspect this is not the correct
>> fix here. Unfortunately the indirect header inclusions in this
>> file are way too complicated with corner cases in various
>> architectures. How much testing have you given your patch
>> across other targets? I think the last time we tried to address
>> it, we broke mips or parisc.
>
> It was build-tested on 0day.
> I also gave it some light boot testing on kunit/qemu.
> (Neither on mips or parisc)

Ok, I see. I checked the usage of these functions again and
now remembered the reason we didn't fix it last time, which is
that the semantics are inconsistent across architectures
and I think this should be addressed first, so we can untangle
the definitions:

There is one driver that is specific to ARM processors
(drivers/firmware/arm_scmi) using  ioread64_hi_lo/iowrite64_hi_lo
and this uses the documented semantics from
Documentation/driver-api/device-io.rst, which says that the
helpers always do separate 32-bit accesses (even on 64-bit
machines), but that it's possible to just call
ioread64()/iowrite64() after including linux/io-64-nonatomic-hi-lo.h
in order to always get 64-bit accesses on 64-bit architectures
but get 32-bit accesses on 32-bit architectures. There are
another dozen or so drivers that do this.

There are two other drivers that were written for x86 that
use other semantics (drivers/net/wwan/t7xx/ and
drivers/ptp/ptp_pch.c): Here, the definition from lib/iomap.c
means that even on 64-bit architectures calling
ioread64_hi_lo/iowrite64_hi_lo on an MMIO space always
results in a 64-bit access, and only the PIO version is split
up. On 32-bit architectures, this part is not provided, so
it should fall back to split access (I think this is where
we had bugs in the past).

Another complication is that alpha, parisc and sh (not mips
any more) explicitly include asm-generic/iomap.h but don't
select CONFIG_GENERIC_IOMAP. At this time, GENERIC_IOMAP
is selected at least in some configurations on m68k, mips,
powerpc, sh, um and x86, but most of these should not do that
(mips, m68k and sh have no PIO instructions, powerpc had
a hack that I think was just removed but needs more cleanup).

I'm testing with the patch below now, which separates the
CONFIG_GENERIC_IOMAP implementation (with the 32-bit PIO
access) from the normal version, and picks an appropriate
one in linux/io-64-nonatomic-*.h based on the architecture
to avoid some of the more confusing nested=20
"#ifdef ioread64" etc checks.

I checked that none of the three drivers ever actually uses
PIO registers instead of MMIO, and since none of them use the
big-endian accessors, this all turns into readq/writeq
in practice anyway.

The ptp_pch.c driver still needs more work as I noticed two
issues there: the driver has a mix of lo_hi and hi_lo
variants, but it is unclear whether is is actually required
on 32-bit or if the hardware works the same either way.
In addition, these seem to be timer registers that may overrun
from the lo into the hi field between the two accesses, so
technically a 32-bit host needs to do an extra read to
check for overflow and possibly repeat the access.

      Arnd

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_s=
cmi/driver.c
index 60050da54bf2..1c75a4c9c371 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1997,17 +1997,7 @@ static void scmi_common_fastchannel_db_ring(struc=
t scmi_fc_db_info *db)
 	else if (db->width =3D=3D 4)
 		SCMI_PROTO_FC_RING_DB(32);
 	else /* db->width =3D=3D 8 */
-#ifdef CONFIG_64BIT
 		SCMI_PROTO_FC_RING_DB(64);
-#else
-	{
-		u64 val =3D 0;
-
-		if (db->mask)
-			val =3D ioread64_hi_lo(db->addr) & db->mask;
-		iowrite64_hi_lo(db->set | val, db->addr);
-	}
-#endif
 }
=20
 /**
diff --git a/drivers/net/wwan/t7xx/t7xx_cldma.c b/drivers/net/wwan/t7xx/=
t7xx_cldma.c
index f0a4783baf1f..9f43f256db1d 100644
--- a/drivers/net/wwan/t7xx/t7xx_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_cldma.c
@@ -106,7 +106,7 @@ bool t7xx_cldma_tx_addr_is_set(struct t7xx_cldma_hw =
*hw_info, unsigned int qno)
 {
 	u32 offset =3D REG_CLDMA_UL_START_ADDRL_0 + qno * ADDR_SIZE;
=20
-	return ioread64_lo_hi(hw_info->ap_pdn_base + offset);
+	return ioread64(hw_info->ap_pdn_base + offset);
 }
=20
 void t7xx_cldma_hw_set_start_addr(struct t7xx_cldma_hw *hw_info, unsign=
ed int qno, u64 address,
@@ -117,7 +117,7 @@ void t7xx_cldma_hw_set_start_addr(struct t7xx_cldma_=
hw *hw_info, unsigned int qn
=20
 	reg =3D tx_rx =3D=3D MTK_RX ? hw_info->ap_ao_base + REG_CLDMA_DL_START=
_ADDRL_0 :
 				hw_info->ap_pdn_base + REG_CLDMA_UL_START_ADDRL_0;
-	iowrite64_lo_hi(address, reg + offset);
+	iowrite64(address, reg + offset);
 }
=20
 void t7xx_cldma_hw_resume_queue(struct t7xx_cldma_hw *hw_info, unsigned=
 int qno,
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t=
7xx/t7xx_hif_cldma.c
index 97163e1e5783..13f5a2442d20 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -137,9 +137,9 @@ static int t7xx_cldma_gpd_rx_from_q(struct cldma_que=
ue *queue, int budget, bool
 				return -ENODEV;
 			}
=20
-			gpd_addr =3D ioread64_lo_hi(hw_info->ap_pdn_base +
-						  REG_CLDMA_DL_CURRENT_ADDRL_0 +
-						  queue->index * sizeof(u64));
+			gpd_addr =3D ioread64(hw_info->ap_pdn_base +
+					    REG_CLDMA_DL_CURRENT_ADDRL_0 +
+					    queue->index * sizeof(u64));
 			if (req->gpd_addr =3D=3D gpd_addr || hwo_polling_count++ >=3D 100)
 				return 0;
=20
@@ -317,8 +317,8 @@ static void t7xx_cldma_txq_empty_hndl(struct cldma_q=
ueue *queue)
 		struct t7xx_cldma_hw *hw_info =3D &md_ctrl->hw_info;
=20
 		/* Check current processing TGPD, 64-bit address is in a table by Q i=
ndex */
-		ul_curr_addr =3D ioread64_lo_hi(hw_info->ap_pdn_base + REG_CLDMA_UL_C=
URRENT_ADDRL_0 +
-					      queue->index * sizeof(u64));
+		ul_curr_addr =3D ioread64(hw_info->ap_pdn_base + REG_CLDMA_UL_CURRENT=
_ADDRL_0 +
+					queue->index * sizeof(u64));
 		if (req->gpd_addr !=3D ul_curr_addr) {
 			spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
 			dev_err(md_ctrl->dev, "CLDMA%d queue %d is not empty\n",
diff --git a/drivers/net/wwan/t7xx/t7xx_pcie_mac.c b/drivers/net/wwan/t7=
xx/t7xx_pcie_mac.c
index f071ec7ff23d..76da4c15e3de 100644
--- a/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
+++ b/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
@@ -75,7 +75,7 @@ static void t7xx_pcie_mac_atr_tables_dis(void __iomem =
*pbase, enum t7xx_atr_src_
 	for (i =3D 0; i < ATR_TABLE_NUM_PER_ATR; i++) {
 		offset =3D ATR_PORT_OFFSET * port + ATR_TABLE_OFFSET * i;
 		reg =3D pbase + ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR + offset;
-		iowrite64_lo_hi(0, reg);
+		iowrite64(0, reg);
 	}
 }
=20
@@ -112,17 +112,17 @@ static int t7xx_pcie_mac_atr_cfg(struct t7xx_pci_d=
ev *t7xx_dev, struct t7xx_atr_
=20
 	reg =3D pbase + ATR_PCIE_WIN0_T0_TRSL_ADDR + offset;
 	value =3D cfg->trsl_addr & ATR_PCIE_WIN0_ADDR_ALGMT;
-	iowrite64_lo_hi(value, reg);
+	iowrite64(value, reg);
=20
 	reg =3D pbase + ATR_PCIE_WIN0_T0_TRSL_PARAM + offset;
 	iowrite32(cfg->trsl_id, reg);
=20
 	reg =3D pbase + ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR + offset;
 	value =3D (cfg->src_addr & ATR_PCIE_WIN0_ADDR_ALGMT) | (atr_size << 1)=
 | BIT(0);
-	iowrite64_lo_hi(value, reg);
+	iowrite64(value, reg);
=20
 	/* Ensure ATR is set */
-	ioread64_lo_hi(reg);
+	ioread64(reg);
 	return 0;
 }
=20
diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index b8a9a54a176c..1d3b1f83cda8 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -147,14 +146,14 @@ static u64 pch_systime_read(struct pch_ts_regs __i=
omem *regs)
 {
 	u64 ns;
=20
-	ns =3D ioread64_lo_hi(&regs->systime_lo);
+	ns =3D ioread64(&regs->systime_lo);
=20
 	return ns << TICKS_NS_SHIFT;
 }
=20
 static void pch_systime_write(struct pch_ts_regs __iomem *regs, u64 ns)
 {
-	iowrite64_lo_hi(ns >> TICKS_NS_SHIFT, &regs->systime_lo);
+	iowrite64(ns >> TICKS_NS_SHIFT, &regs->systime_lo);
 }
=20
 static inline void pch_block_reset(struct pch_dev *chip)
@@ -221,7 +220,7 @@ u64 pch_rx_snap_read(struct pci_dev *pdev)
 	struct pch_dev *chip =3D pci_get_drvdata(pdev);
 	u64 ns;
=20
-	ns =3D ioread64_lo_hi(&chip->regs->rx_snap_lo);
+	ns =3D ioread64(&chip->regs->rx_snap_lo);
=20
 	return ns << TICKS_NS_SHIFT;
 }
@@ -232,7 +231,7 @@ u64 pch_tx_snap_read(struct pci_dev *pdev)
 	struct pch_dev *chip =3D pci_get_drvdata(pdev);
 	u64 ns;
=20
-	ns =3D ioread64_lo_hi(&chip->regs->tx_snap_lo);
+	ns =3D ioread64(&chip->regs->tx_snap_lo);
=20
 	return ns << TICKS_NS_SHIFT;
 }
@@ -283,7 +282,7 @@ int pch_set_station_address(u8 *addr, struct pci_dev=
 *pdev)
 	}
=20
 	dev_dbg(&pdev->dev, "invoking pch_station_set\n");
-	iowrite64_lo_hi(mac, &chip->regs->ts_st);
+	iowrite64(mac, &chip->regs->ts_st);
 	return 0;
 }
 EXPORT_SYMBOL(pch_set_station_address);
@@ -305,7 +304,7 @@ static irqreturn_t isr(int irq, void *priv)
 		if (pch_dev->exts0_enabled) {
 			event.type =3D PTP_CLOCK_EXTTS;
 			event.index =3D 0;
-			event.timestamp =3D ioread64_hi_lo(&regs->asms_hi);
+			event.timestamp =3D ioread64(&regs->asms_hi);
 			event.timestamp <<=3D TICKS_NS_SHIFT;
 			ptp_clock_event(pch_dev->ptp_clock, &event);
 		}
@@ -316,7 +315,7 @@ static irqreturn_t isr(int irq, void *priv)
 		if (pch_dev->exts1_enabled) {
 			event.type =3D PTP_CLOCK_EXTTS;
 			event.index =3D 1;
-			event.timestamp =3D ioread64_hi_lo(&regs->asms_hi);
+			event.timestamp =3D ioread64(&regs->asms_hi);
 			event.timestamp <<=3D TICKS_NS_SHIFT;
 			ptp_clock_event(pch_dev->ptp_clock, &event);
 		}
@@ -493,7 +492,7 @@ pch_probe(struct pci_dev *pdev, const struct pci_dev=
ice_id *id)
 	pch_reset(chip);
=20
 	iowrite32(DEFAULT_ADDEND, &chip->regs->addend);
-	iowrite64_lo_hi(1, &chip->regs->trgt_lo);
+	iowrite64(1, &chip->regs->trgt_lo);
 	iowrite32(PCH_TSE_TTIPEND, &chip->regs->event);
=20
 	pch_eth_enable_set(chip);
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 196087a8126e..9f3f25d7fc58 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -31,42 +31,22 @@ extern unsigned int ioread16(const void __iomem *);
 extern unsigned int ioread16be(const void __iomem *);
 extern unsigned int ioread32(const void __iomem *);
 extern unsigned int ioread32be(const void __iomem *);
-#ifdef CONFIG_64BIT
-extern u64 ioread64(const void __iomem *);
-extern u64 ioread64be(const void __iomem *);
-#endif
=20
-#ifdef readq
-#define ioread64_lo_hi ioread64_lo_hi
-#define ioread64_hi_lo ioread64_hi_lo
-#define ioread64be_lo_hi ioread64be_lo_hi
-#define ioread64be_hi_lo ioread64be_hi_lo
-extern u64 ioread64_lo_hi(const void __iomem *addr);
-extern u64 ioread64_hi_lo(const void __iomem *addr);
-extern u64 ioread64be_lo_hi(const void __iomem *addr);
-extern u64 ioread64be_hi_lo(const void __iomem *addr);
-#endif
+extern u64 __ioread64_lo_hi(const void __iomem *addr);
+extern u64 __ioread64_hi_lo(const void __iomem *addr);
+extern u64 __ioread64be_lo_hi(const void __iomem *addr);
+extern u64 __ioread64be_hi_lo(const void __iomem *addr);
=20
 extern void iowrite8(u8, void __iomem *);
 extern void iowrite16(u16, void __iomem *);
 extern void iowrite16be(u16, void __iomem *);
 extern void iowrite32(u32, void __iomem *);
 extern void iowrite32be(u32, void __iomem *);
-#ifdef CONFIG_64BIT
-extern void iowrite64(u64, void __iomem *);
-extern void iowrite64be(u64, void __iomem *);
-#endif
=20
-#ifdef writeq
-#define iowrite64_lo_hi iowrite64_lo_hi
-#define iowrite64_hi_lo iowrite64_hi_lo
-#define iowrite64be_lo_hi iowrite64be_lo_hi
-#define iowrite64be_hi_lo iowrite64be_hi_lo
-extern void iowrite64_lo_hi(u64 val, void __iomem *addr);
-extern void iowrite64_hi_lo(u64 val, void __iomem *addr);
-extern void iowrite64be_lo_hi(u64 val, void __iomem *addr);
-extern void iowrite64be_hi_lo(u64 val, void __iomem *addr);
-#endif
+extern void __iowrite64_lo_hi(u64 val, void __iomem *addr);
+extern void __iowrite64_hi_lo(u64 val, void __iomem *addr);
+extern void __iowrite64be_lo_hi(u64 val, void __iomem *addr);
+extern void __iowrite64be_hi_lo(u64 val, void __iomem *addr);
=20
 /*
  * "string" versions of the above. Note that they
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64=
-nonatomic-lo-hi.h
index 448a21435dba..70d091769baa 100644
--- a/include/linux/io-64-nonatomic-lo-hi.h
+++ b/include/linux/io-64-nonatomic-lo-hi.h
@@ -101,22 +101,38 @@ static inline void iowrite64be_lo_hi(u64 val, void=
 __iomem *addr)
=20
 #ifndef ioread64
 #define ioread64_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define ioread64 __ioread64_lo_hi
+#else
 #define ioread64 ioread64_lo_hi
 #endif
+#endif
=20
 #ifndef iowrite64
 #define iowrite64_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define ioread64 __iowrite64_lo_hi
+#else
 #define iowrite64 iowrite64_lo_hi
 #endif
+#endif
=20
 #ifndef ioread64be
 #define ioread64be_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define ioread64 __ioread64be_lo_hi
+#else
 #define ioread64be ioread64be_lo_hi
 #endif
+#endif
=20
 #ifndef iowrite64be
 #define iowrite64be_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define ioread64 __iowrite64be_lo_hi
+#else
 #define iowrite64be iowrite64be_lo_hi
 #endif
+#endif
=20
 #endif	/* _LINUX_IO_64_NONATOMIC_LO_HI_H_ */
diff --git a/lib/iomap.c b/lib/iomap.c
index 4f8b31baa575..a65717cd86f7 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -111,7 +111,7 @@ EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
=20
-#ifdef readq
+#ifdef CONFIG_64BIT
 static u64 pio_read64_lo_hi(unsigned long port)
 {
 	u64 lo, hi;
@@ -153,21 +153,21 @@ static u64 pio_read64be_hi_lo(unsigned long port)
 }
=20
 __no_kmsan_checks
-u64 ioread64_lo_hi(const void __iomem *addr)
+u64 __ioread64_lo_hi(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64_lo_hi(port), return readq(addr));
 	return 0xffffffffffffffffULL;
 }
=20
 __no_kmsan_checks
-u64 ioread64_hi_lo(const void __iomem *addr)
+u64 __ioread64_hi_lo(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64_hi_lo(port), return readq(addr));
 	return 0xffffffffffffffffULL;
 }
=20
 __no_kmsan_checks
-u64 ioread64be_lo_hi(const void __iomem *addr)
+u64 __ioread64be_lo_hi(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64be_lo_hi(port),
 		return mmio_read64be(addr));
@@ -175,19 +175,19 @@ u64 ioread64be_lo_hi(const void __iomem *addr)
 }
=20
 __no_kmsan_checks
-u64 ioread64be_hi_lo(const void __iomem *addr)
+u64 __ioread64be_hi_lo(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64be_hi_lo(port),
 		return mmio_read64be(addr));
 	return 0xffffffffffffffffULL;
 }
=20
-EXPORT_SYMBOL(ioread64_lo_hi);
-EXPORT_SYMBOL(ioread64_hi_lo);
-EXPORT_SYMBOL(ioread64be_lo_hi);
-EXPORT_SYMBOL(ioread64be_hi_lo);
+EXPORT_SYMBOL(__ioread64_lo_hi);
+EXPORT_SYMBOL(__ioread64_hi_lo);
+EXPORT_SYMBOL(__ioread64be_lo_hi);
+EXPORT_SYMBOL(__ioread64be_hi_lo);
=20
-#endif /* readq */
+#endif /* CONFIG_64BIT */
=20
 #ifndef pio_write16be
 #define pio_write16be(val,port) outw(swab16(val),port)
@@ -236,7 +236,7 @@ EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
=20
-#ifdef writeq
+#ifdef CONFIG_64BIT
 static void pio_write64_lo_hi(u64 val, unsigned long port)
 {
 	outl(val, port);
@@ -261,7 +261,7 @@ static void pio_write64be_hi_lo(u64 val, unsigned lo=
ng port)
 	pio_write32be(val, port + sizeof(u32));
 }
=20
-void iowrite64_lo_hi(u64 val, void __iomem *addr)
+void __iowrite64_lo_hi(u64 val, void __iomem *addr)
 {
 	/* Make sure uninitialized memory isn't copied to devices. */
 	kmsan_check_memory(&val, sizeof(val));
@@ -269,7 +269,7 @@ void iowrite64_lo_hi(u64 val, void __iomem *addr)
 		writeq(val, addr));
 }
=20
-void iowrite64_hi_lo(u64 val, void __iomem *addr)
+void __iowrite64_hi_lo(u64 val, void __iomem *addr)
 {
 	/* Make sure uninitialized memory isn't copied to devices. */
 	kmsan_check_memory(&val, sizeof(val));
@@ -277,7 +277,7 @@ void iowrite64_hi_lo(u64 val, void __iomem *addr)
 		writeq(val, addr));
 }
=20
-void iowrite64be_lo_hi(u64 val, void __iomem *addr)
+void __iowrite64be_lo_hi(u64 val, void __iomem *addr)
 {
 	/* Make sure uninitialized memory isn't copied to devices. */
 	kmsan_check_memory(&val, sizeof(val));
@@ -285,7 +285,7 @@ void iowrite64be_lo_hi(u64 val, void __iomem *addr)
 		mmio_write64be(val, addr));
 }
=20
-void iowrite64be_hi_lo(u64 val, void __iomem *addr)
+void __iowrite64be_hi_lo(u64 val, void __iomem *addr)
 {
 	/* Make sure uninitialized memory isn't copied to devices. */
 	kmsan_check_memory(&val, sizeof(val));
@@ -293,12 +293,12 @@ void iowrite64be_hi_lo(u64 val, void __iomem *addr)
 		mmio_write64be(val, addr));
 }
=20
-EXPORT_SYMBOL(iowrite64_lo_hi);
-EXPORT_SYMBOL(iowrite64_hi_lo);
-EXPORT_SYMBOL(iowrite64be_lo_hi);
-EXPORT_SYMBOL(iowrite64be_hi_lo);
+EXPORT_SYMBOL(__iowrite64_lo_hi);
+EXPORT_SYMBOL(__iowrite64_hi_lo);
+EXPORT_SYMBOL(__iowrite64be_lo_hi);
+EXPORT_SYMBOL(__iowrite64be_hi_lo);
=20
-#endif /* readq */
+#endif /* CONFIG_64BIT */
=20
 /*
  * These are the "repeat MMIO read/write" functions.

