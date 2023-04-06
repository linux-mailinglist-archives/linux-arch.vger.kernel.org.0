Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A236D9A18
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjDFOaz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDFOab (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 10:30:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AB893C5;
        Thu,  6 Apr 2023 07:30:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74FB81FE59;
        Thu,  6 Apr 2023 14:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680791425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eo/bLXguw7MdHhtP9FcQvxJmrLre1vl8fbgQMpoea24=;
        b=y6UbgE+pcY2f7xbuIFRWFqUzWrJpOA+uYuv7oP0daH2jfrwta+dhYkzEIKdXqS4Wx3bO3Y
        5OaPNzRbxk5/4ew/68u+MV/+AGJPZSkoUciC+u3o2swA9kGa2CUrQrpcOTCFj/mp7xcWeW
        vquMTyuABeDw48opTWtGPpwZaPI2Lig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680791425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eo/bLXguw7MdHhtP9FcQvxJmrLre1vl8fbgQMpoea24=;
        b=qX6BnNf7BU7JJxdPt0qT3qYNE/EwrjABNsUrAGK2xQPtuTOVhuZWnhMwQKLiRF8XnvspOI
        /DCcyaclMcReQNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E12F1351F;
        Thu,  6 Apr 2023 14:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJ2HAoHXLmS4LgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Apr 2023 14:30:25 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de,
        javierm@redhat.com, gregkh@linuxfoundation.org
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 10/19] video: Remove trailing whitespaces
Date:   Thu,  6 Apr 2023 16:30:10 +0200
Message-Id: <20230406143019.6709-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406143019.6709-1-tzimmermann@suse.de>
References: <20230406143019.6709-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix trailing whitespaces. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/sticon.c  |   4 +-
 drivers/video/console/sticore.c | 102 ++++++++++-----------
 drivers/video/fbdev/sticore.h   |  14 +--
 drivers/video/fbdev/stifb.c     | 156 ++++++++++++++++----------------
 4 files changed, 138 insertions(+), 138 deletions(-)

diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 2cea69418a83..89ad7ade6cf9 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -282,7 +282,7 @@ static void sticon_init(struct vc_data *c, int init)
     vc_cols = sti_onscreen_x(sti) / sti->font->width;
     vc_rows = sti_onscreen_y(sti) / sti->font->height;
     c->vc_can_do_color = 1;
-    
+
     if (init) {
 	c->vc_cols = vc_cols;
 	c->vc_rows = vc_rows;
@@ -374,7 +374,7 @@ static const struct consw sti_con = {
 	.con_font_set		= sticon_font_set,
 	.con_font_default	= sticon_font_default,
 	.con_build_attr		= sticon_build_attr,
-	.con_invert_region	= sticon_invert_region, 
+	.con_invert_region	= sticon_invert_region,
 };
 
 
diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index db568f67e4dc..6ea9596a3c4b 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -6,12 +6,12 @@
  *	Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>
  *	Copyright (C) 2001-2020 Helge Deller <deller@gmx.de>
  *	Copyright (C) 2001-2002 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
- * 
+ *
  * TODO:
  * - call STI in virtual mode rather than in real mode
- * - screen blanking with state_mgmt() in text mode STI ? 
+ * - screen blanking with state_mgmt() in text mode STI ?
  * - try to make it work on m68k hp workstations ;)
- * 
+ *
  */
 
 #define pr_fmt(fmt) "%s: " fmt, KBUILD_MODNAME
@@ -66,12 +66,12 @@ static const u8 col_trans[8] = {
 #define c_index(sti, c) ((c) & 0xff)
 
 static const struct sti_init_flags default_init_flags = {
-	.wait	= STI_WAIT, 
+	.wait	= STI_WAIT,
 	.reset	= 1,
-	.text	= 1, 
+	.text	= 1,
 	.nontext = 1,
-	.no_chg_bet = 1, 
-	.no_chg_bei = 1, 
+	.no_chg_bet = 1,
+	.no_chg_bei = 1,
 	.init_cmap_tx = 1,
 };
 
@@ -104,7 +104,7 @@ static int sti_init_graph(struct sti_struct *sti)
 		pr_err("STI init_graph failed (ret %d, errno %d)\n", ret, err);
 		return -1;
 	}
-	
+
 	return 0;
 }
 
@@ -120,7 +120,7 @@ static void sti_inq_conf(struct sti_struct *sti)
 	s32 ret;
 
 	outptr->ext_ptr = STI_PTR(&sti->sti_data->inq_outptr_ext);
-	
+
 	do {
 		spin_lock_irqsave(&sti->lock, flags);
 		memset(inptr, 0, sizeof(*inptr));
@@ -162,9 +162,9 @@ sti_putc(struct sti_struct *sti, int c, int y, int x,
 }
 
 static const struct sti_blkmv_flags clear_blkmv_flags = {
-	.wait	= STI_WAIT, 
-	.color	= 1, 
-	.clear	= 1, 
+	.wait	= STI_WAIT,
+	.color	= 1,
+	.clear	= 1,
 };
 
 void
@@ -185,7 +185,7 @@ sti_set(struct sti_struct *sti, int src_y, int src_x,
 	struct sti_blkmv_outptr *outptr = &sti->sti_data->blkmv_outptr;
 	s32 ret;
 	unsigned long flags;
-	
+
 	do {
 		spin_lock_irqsave(&sti->lock, flags);
 		*inptr = inptr_default;
@@ -224,7 +224,7 @@ sti_clear(struct sti_struct *sti, int src_y, int src_x,
 }
 
 static const struct sti_blkmv_flags default_blkmv_flags = {
-	.wait = STI_WAIT, 
+	.wait = STI_WAIT,
 };
 
 void
@@ -291,14 +291,14 @@ static int __init sti_setup(char *str)
 {
 	if (str)
 		strscpy(default_sti_path, str, sizeof(default_sti_path));
-	
+
 	return 1;
 }
 
 /*	Assuming the machine has multiple STI consoles (=graphic cards) which
  *	all get detected by sticon, the user may define with the linux kernel
  *	parameter sti=<x> which of them will be the initial boot-console.
- *	<x> is a number between 0 and MAX_STI_ROMS, with 0 as the default 
+ *	<x> is a number between 0 and MAX_STI_ROMS, with 0 as the default
  *	STI screen.
  */
 __setup("sti=", sti_setup);
@@ -341,13 +341,13 @@ static int sti_font_setup(char *str)
  *	should be used by the sticon driver to draw characters to the screen.
  *	Possible values are:
  *	- sti_font=<fb_fontname>:
- *		<fb_fontname> is the name of one of the linux-kernel built-in 
- *		framebuffer font names (e.g. VGA8x16, SUN22x18). 
- *		This is only available if the fonts have been statically compiled 
+ *		<fb_fontname> is the name of one of the linux-kernel built-in
+ *		framebuffer font names (e.g. VGA8x16, SUN22x18).
+ *		This is only available if the fonts have been statically compiled
  *		in with e.g. the CONFIG_FONT_8x16 or CONFIG_FONT_SUN12x22 options.
  *	- sti_font=<number>	(<number> = 1,2,3,...)
  *		most STI ROMs have built-in HP specific fonts, which can be selected
- *		by giving the desired number to the sticon driver. 
+ *		by giving the desired number to the sticon driver.
  *		NOTE: This number is machine and STI ROM dependend.
  *	- sti_font=<height>x<width>  (e.g. sti_font=16x8)
  *		<height> and <width> gives hints to the height and width of the
@@ -359,12 +359,12 @@ __setup("sti_font=", sti_font_setup);
 #endif
 
 
-	
+
 static void sti_dump_globcfg(struct sti_glob_cfg *glob_cfg,
 			     unsigned int sti_mem_request)
 {
 	struct sti_glob_cfg_ext *cfg;
-	
+
 	pr_debug("%d text planes\n"
 		"%4d x %4d screen resolution\n"
 		"%4d x %4d offscreen\n"
@@ -384,7 +384,7 @@ static void sti_dump_globcfg(struct sti_glob_cfg *glob_cfg,
 		glob_cfg->reent_lvl,
 		glob_cfg->save_addr);
 
-	/* dump extended cfg */ 
+	/* dump extended cfg */
 	cfg = PTR_STI((unsigned long)glob_cfg->ext_ptr);
 	pr_debug("monitor %d\n"
 		"in friendly mode: %d\n"
@@ -437,10 +437,10 @@ static int sti_init_glob_cfg(struct sti_struct *sti, unsigned long rom_address,
 	glob_cfg->save_addr = STI_PTR(save_addr);
 	for (i=0; i<8; i++) {
 		unsigned long newhpa, len;
-	       
+
 		if (sti->pd) {
 			unsigned char offs = sti->rm_entry[i];
-				
+
 			if (offs == 0)
 				continue;
 			if (offs != PCI_ROM_ADDRESS &&
@@ -456,18 +456,18 @@ static int sti_init_glob_cfg(struct sti_struct *sti, unsigned long rom_address,
 
 		sti->regions_phys[i] =
 			REGION_OFFSET_TO_PHYS(sti->regions[i], newhpa);
-		
+
 		len = sti->regions[i].region_desc.length * 4096;
 		if (len)
 			glob_cfg->region_ptrs[i] = sti->regions_phys[i];
-		
+
 		pr_debug("region #%d: phys %08lx, region_ptr %08x, len=%lukB, "
 			 "btlb=%d, sysonly=%d, cache=%d, last=%d\n",
 			i, sti->regions_phys[i], glob_cfg->region_ptrs[i],
 			len/1024,
 			sti->regions[i].region_desc.btlb,
 			sti->regions[i].region_desc.sys_only,
-			sti->regions[i].region_desc.cache, 
+			sti->regions[i].region_desc.cache,
 			sti->regions[i].region_desc.last);
 
 		/* last entry reached ? */
@@ -482,7 +482,7 @@ static int sti_init_glob_cfg(struct sti_struct *sti, unsigned long rom_address,
 	glob_cfg_ext->sti_mem_addr = STI_PTR(sti_mem_addr);
 
 	sti->glob_cfg = glob_cfg;
-	
+
 	return 0;
 }
 
@@ -495,7 +495,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 	void *dest;
 	struct sti_rom_font *nf;
 	struct sti_cooked_font *cooked_font;
-	
+
 	if (fbfont_name && strlen(fbfont_name))
 		fbfont = find_font(fbfont_name);
 	if (!fbfont)
@@ -505,8 +505,8 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 
 	pr_info("    using %ux%u framebuffer font %s\n",
 			fbfont->width, fbfont->height, fbfont->name);
-			
-	bpc = ((fbfont->width+7)/8) * fbfont->height; 
+
+	bpc = ((fbfont->width+7)/8) * fbfont->height;
 	size = bpc * fbfont->charcount;
 	size += sizeof(struct sti_rom_font);
 
@@ -533,7 +533,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 		kfree(nf);
 		return NULL;
 	}
-	
+
 	cooked_font->raw = nf;
 	cooked_font->raw_ptr = nf;
 	cooked_font->next_font = NULL;
@@ -617,9 +617,9 @@ static void sti_dump_rom(struct sti_struct *sti)
 	int nr;
 
 	pr_info("  id %04x-%04x, conforms to spec rev. %d.%02x\n",
-		rom->graphics_id[0], 
+		rom->graphics_id[0],
 		rom->graphics_id[1],
-		rom->revno[0] >> 4, 
+		rom->revno[0] >> 4,
 		rom->revno[0] & 0x0f);
 	pr_debug("  supports %d monitors\n", rom->num_mons);
 	pr_debug("  font start %08x\n", rom->font_start);
@@ -647,7 +647,7 @@ static int sti_cook_fonts(struct sti_cooked_rom *cooked_rom,
 {
 	struct sti_rom_font *raw_font, *font_start;
 	struct sti_cooked_font *cooked_font;
-	
+
 	cooked_font = kzalloc(sizeof(*cooked_font), GFP_KERNEL);
 	if (!cooked_font)
 		return 0;
@@ -745,7 +745,7 @@ static struct sti_rom *sti_get_bmode_rom (unsigned long address)
 
 		raw_font = ((void *)raw) + raw->font_start;
 		font_start = raw_font;
-		
+
 		while (raw_font->next_font) {
 			BMODE_RELOCATE (raw_font->next_font);
 			raw_font = ((void *)font_start) + raw_font->next_font;
@@ -759,7 +759,7 @@ static struct sti_rom *sti_get_wmode_rom(unsigned long address)
 	struct sti_rom *raw;
 	unsigned long size;
 
-	/* read the ROM size directly from the struct in ROM */ 
+	/* read the ROM size directly from the struct in ROM */
 	size = gsc_readl(address + offsetof(struct sti_rom,last_addr));
 
 	raw = kmalloc(size, STI_LOWMEM);
@@ -869,7 +869,7 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 		pr_warn("maximum number of STI ROMS reached !\n");
 		return NULL;
 	}
-	
+
 	sti = kzalloc(sizeof(*sti), GFP_KERNEL);
 	if (!sti)
 		return NULL;
@@ -890,19 +890,19 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 		u32 *rm;
 		i = gsc_readl(address+0x04);
 		if (i != 1) {
-			/* The ROM could have multiple architecture 
+			/* The ROM could have multiple architecture
 			 * dependent images (e.g. i386, parisc,...) */
 			pr_warn("PCI ROM is not a STI ROM type image (0x%8x)\n", i);
 			goto out_err;
 		}
-		
+
 		sti->pd = pd;
 
 		i = gsc_readl(address+0x0c);
 		pr_debug("PCI ROM size (from header) = %d kB\n",
 			le16_to_cpu(i>>16)*512/1024);
 		rm_offset = le16_to_cpu(i & 0xffff);
-		if (rm_offset) { 
+		if (rm_offset) {
 			/* read 16 bytes from the pci region mapper array */
 			rm = (u32*) &sti->rm_entry;
 			*rm++ = gsc_readl(address+rm_offset+0x00);
@@ -915,9 +915,9 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 		pr_debug("sig %04x, PCI STI ROM at %08lx\n", sig, address);
 		goto test_rom;
 	}
-	
+
 	ok = 0;
-	
+
 	if ((sig & 0xff) == 0x01) {
 		pr_debug("    byte mode ROM at %08lx, hpa at %08lx\n",
 		       address, hpa);
@@ -941,7 +941,7 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 	 */
 	if (sti->pd) {
 		unsigned long rom_base;
-		rom_base = pci_resource_start(sti->pd, PCI_ROM_RESOURCE);	
+		rom_base = pci_resource_start(sti->pd, PCI_ROM_RESOURCE);
 		pci_write_config_dword(sti->pd, PCI_ROM_ADDRESS, rom_base & ~PCI_ROM_ADDRESS_ENABLE);
 		pr_debug("STI PCI ROM disabled\n");
 	}
@@ -952,13 +952,13 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 	sti_inq_conf(sti);
 	sti_dump_globcfg(sti->glob_cfg, sti->sti_mem_request);
 	sti_dump_outptr(sti);
-	
+
 	pr_info("    graphics card name: %s\n",
 		sti->sti_data->inq_outptr.dev_name);
 
 	sti_roms[num_sti_roms] = sti;
 	num_sti_roms++;
-	
+
 	return sti;
 
 out_err:
@@ -974,9 +974,9 @@ static void sticore_check_for_default_sti(struct sti_struct *sti, char *path)
 }
 
 /*
- * on newer systems PDC gives the address of the ROM 
+ * on newer systems PDC gives the address of the ROM
  * in the additional address field addr[1] while on
- * older Systems the PDC stores it in page0->proc_sti 
+ * older Systems the PDC stores it in page0->proc_sti
  */
 static int __init sticore_pa_init(struct parisc_device *dev)
 {
@@ -1005,7 +1005,7 @@ static int sticore_pci_init(struct pci_dev *pd, const struct pci_device_id *ent)
 	unsigned int fb_len, rom_len;
 	int err;
 	struct sti_struct *sti;
-	
+
 	err = pci_enable_device(pd);
 	if (err < 0) {
 		dev_err(&pd->dev, "Cannot enable PCI device\n");
@@ -1032,7 +1032,7 @@ static int sticore_pci_init(struct pci_dev *pd, const struct pci_device_id *ent)
 		print_pci_hwpath(pd, sti->pa_path);
 		sticore_check_for_default_sti(sti, sti->pa_path);
 	}
-	
+
 	if (!sti) {
 		pr_warn("Unable to handle STI device '%s'\n", pci_name(pd));
 		return -ENODEV;
diff --git a/drivers/video/fbdev/sticore.h b/drivers/video/fbdev/sticore.h
index 0ebdd28a0b81..c0879352cde4 100644
--- a/drivers/video/fbdev/sticore.h
+++ b/drivers/video/fbdev/sticore.h
@@ -27,11 +27,11 @@
  *
  * Probably the best solution to all this is have the generic code manage
  * the screen buffer and a kernel thread to call STI occasionally.
- * 
+ *
  * Luckily, the frame buffer guys have the same problem so we can just wait
  * for them to fix it and steal their solution.   prumpf
  */
- 
+
 #include <asm/io.h>
 
 #define STI_WAIT 1
@@ -56,7 +56,7 @@
 /* STI function configuration structs */
 
 typedef union region {
-	struct { 
+	struct {
 		u32 offset	: 14;	/* offset in 4kbyte page */
 		u32 sys_only	: 1;	/* don't map to user space */
 		u32 cache	: 1;	/* map to data cache */
@@ -154,7 +154,7 @@ struct sti_conf_inptr {
 };
 
 struct sti_conf_outptr_ext {
-	u32 crt_config[3];	/* hardware specific X11/OGL information */	
+	u32 crt_config[3];	/* hardware specific X11/OGL information */
 	u32 crt_hdw[3];
 	u32 future_ptr;
 };
@@ -211,7 +211,7 @@ struct sti_rom {
 	u32 set_cm_entry;
 	u32 dma_ctrl;
 	 u8 res040[7 * 4];
-	
+
 	u32 init_graph_addr;
 	u32 state_mgmt_addr;
 	u32 font_unp_addr;
@@ -271,7 +271,7 @@ struct sti_font_flags {
 	u32 pad : 30;		/* pad to word boundary */
 	u32 future_ptr; 	/* pointer to future data */
 };
-	
+
 struct sti_font_outptr {
 	s32 errno;		/* error number on failure */
 	u32 future_ptr; 	/* pointer to future data */
@@ -338,7 +338,7 @@ struct sti_all_data {
 
 struct sti_struct {
 	spinlock_t lock;
-		
+
 	/* char **mon_strings; */
 	int sti_mem_request;
 	u32 graphics_id[2];
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index ef8a4c5fc687..99996bc7e6d9 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1,11 +1,11 @@
 /*
- * linux/drivers/video/stifb.c - 
- * Low level Frame buffer driver for HP workstations with 
+ * linux/drivers/video/stifb.c -
+ * Low level Frame buffer driver for HP workstations with
  * STI (standard text interface) video firmware.
  *
  * Copyright (C) 2001-2006 Helge Deller <deller@gmx.de>
  * Portions Copyright (C) 2001 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
- * 
+ *
  * Based on:
  * - linux/drivers/video/artistfb.c -- Artist frame buffer driver
  *	Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>
@@ -14,7 +14,7 @@
  * - HP Xhp cfb-based X11 window driver for XFree86
  *	(c)Copyright 1992 Hewlett-Packard Co.
  *
- * 
+ *
  *  The following graphics display devices (NGLE family) are supported by this driver:
  *
  *  HPA4070A	known as "HCRX", a 1280x1024 color device with 8 planes
@@ -30,7 +30,7 @@
  *		supports 1280x1024 color displays with 8 planes.
  *  HP710G	same as HP710C, 1280x1024 grayscale only
  *  HP710L	same as HP710C, 1024x768 color only
- *  HP712	internal graphics support on HP9000s712 SPU, supports 640x480, 
+ *  HP712	internal graphics support on HP9000s712 SPU, supports 640x480,
  *		1024x768 or 1280x1024 color displays on 8 planes (Artist)
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -92,7 +92,7 @@ typedef struct {
 	__s32	misc_video_end;
 } video_setup_t;
 
-typedef struct {                  
+typedef struct {
 	__s16	sizeof_ngle_data;
 	__s16	x_size_visible;	    /* visible screen dim in pixels  */
 	__s16	y_size_visible;
@@ -177,10 +177,10 @@ static int __initdata stifb_bpp_pref[MAX_STI_ROMS];
 #endif /* DEBUG_STIFB_REGS */
 
 
-#define ENABLE	1	/* for enabling/disabling screen */	
+#define ENABLE	1	/* for enabling/disabling screen */
 #define DISABLE 0
 
-#define NGLE_LOCK(fb_info)	do { } while (0) 
+#define NGLE_LOCK(fb_info)	do { } while (0)
 #define NGLE_UNLOCK(fb_info)	do { } while (0)
 
 static void
@@ -198,9 +198,9 @@ SETUP_HW(struct stifb_info *fb)
 
 static void
 SETUP_FB(struct stifb_info *fb)
-{	
+{
 	unsigned int reg10_value = 0;
-	
+
 	SETUP_HW(fb);
 	switch (fb->id)
 	{
@@ -210,15 +210,15 @@ SETUP_FB(struct stifb_info *fb)
 			reg10_value = 0x13601000;
 			break;
 		case S9000_ID_A1439A:
-			if (fb->info.var.bits_per_pixel == 32)						
+			if (fb->info.var.bits_per_pixel == 32)
 				reg10_value = 0xBBA0A000;
-			else 
+			else
 				reg10_value = 0x13601000;
 			break;
 		case S9000_ID_HCRX:
 			if (fb->info.var.bits_per_pixel == 32)
 				reg10_value = 0xBBA0A000;
-			else					
+			else
 				reg10_value = 0x13602000;
 			break;
 		case S9000_ID_TIMBER:
@@ -243,7 +243,7 @@ START_IMAGE_COLORMAP_ACCESS(struct stifb_info *fb)
 }
 
 static void
-WRITE_IMAGE_COLOR(struct stifb_info *fb, int index, int color) 
+WRITE_IMAGE_COLOR(struct stifb_info *fb, int index, int color)
 {
 	SETUP_HW(fb);
 	WRITE_WORD(((0x100+index)<<2), fb, REG_3);
@@ -251,30 +251,30 @@ WRITE_IMAGE_COLOR(struct stifb_info *fb, int index, int color)
 }
 
 static void
-FINISH_IMAGE_COLORMAP_ACCESS(struct stifb_info *fb) 
-{		
+FINISH_IMAGE_COLORMAP_ACCESS(struct stifb_info *fb)
+{
 	WRITE_WORD(0x400, fb, REG_2);
 	if (fb->info.var.bits_per_pixel == 32) {
 		WRITE_WORD(0x83000100, fb, REG_1);
 	} else {
 		if (fb->id == S9000_ID_ARTIST || fb->id == CRT_ID_VISUALIZE_EG)
 			WRITE_WORD(0x80000100, fb, REG_26);
-		else							
+		else
 			WRITE_WORD(0x80000100, fb, REG_1);
 	}
 	SETUP_FB(fb);
 }
 
 static void
-SETUP_RAMDAC(struct stifb_info *fb) 
+SETUP_RAMDAC(struct stifb_info *fb)
 {
 	SETUP_HW(fb);
 	WRITE_WORD(0x04000000, fb, 0x1020);
 	WRITE_WORD(0xff000000, fb, 0x1028);
 }
 
-static void 
-CRX24_SETUP_RAMDAC(struct stifb_info *fb) 
+static void
+CRX24_SETUP_RAMDAC(struct stifb_info *fb)
 {
 	SETUP_HW(fb);
 	WRITE_WORD(0x04000000, fb, 0x1000);
@@ -286,14 +286,14 @@ CRX24_SETUP_RAMDAC(struct stifb_info *fb)
 }
 
 #if 0
-static void 
+static void
 HCRX_SETUP_RAMDAC(struct stifb_info *fb)
 {
 	WRITE_WORD(0xffffffff, fb, REG_32);
 }
 #endif
 
-static void 
+static void
 CRX24_SET_OVLY_MASK(struct stifb_info *fb)
 {
 	SETUP_HW(fb);
@@ -314,7 +314,7 @@ ENABLE_DISABLE_DISPLAY(struct stifb_info *fb, int enable)
         WRITE_WORD(value, 	fb, 0x1038);
 }
 
-static void 
+static void
 CRX24_ENABLE_DISABLE_DISPLAY(struct stifb_info *fb, int enable)
 {
 	unsigned int value = enable ? 0x10000000 : 0x30000000;
@@ -325,11 +325,11 @@ CRX24_ENABLE_DISABLE_DISPLAY(struct stifb_info *fb, int enable)
 }
 
 static void
-ARTIST_ENABLE_DISABLE_DISPLAY(struct stifb_info *fb, int enable) 
+ARTIST_ENABLE_DISABLE_DISPLAY(struct stifb_info *fb, int enable)
 {
 	u32 DregsMiscVideo = REG_21;
 	u32 DregsMiscCtl = REG_27;
-	
+
 	SETUP_HW(fb);
 	if (enable) {
 	  WRITE_WORD(READ_WORD(fb, DregsMiscVideo) | 0x0A000000, fb, DregsMiscVideo);
@@ -344,7 +344,7 @@ ARTIST_ENABLE_DISABLE_DISPLAY(struct stifb_info *fb, int enable)
 	(READ_BYTE(fb, REG_16b3) - 1)
 
 #define HYPER_CONFIG_PLANES_24 0x00000100
-	
+
 #define IS_24_DEVICE(fb) \
 	(fb->deviceSpecificConfig & HYPER_CONFIG_PLANES_24)
 
@@ -470,15 +470,15 @@ SETUP_ATTR_ACCESS(struct stifb_info *fb, unsigned BufferNumber)
 }
 
 static void
-SET_ATTR_SIZE(struct stifb_info *fb, int width, int height) 
+SET_ATTR_SIZE(struct stifb_info *fb, int width, int height)
 {
-	/* REG_6 seems to have special values when run on a 
+	/* REG_6 seems to have special values when run on a
 	   RDI precisionbook parisc laptop (INTERNAL_EG_DX1024 or
 	   INTERNAL_EG_X1024).  The values are:
 		0x2f0: internal (LCD) & external display enabled
 		0x2a0: external display only
 		0x000: zero on standard artist graphic cards
-	*/ 
+	*/
 	WRITE_WORD(0x00000000, fb, REG_6);
 	WRITE_WORD((width<<16) | height, fb, REG_9);
 	WRITE_WORD(0x05000000, fb, REG_6);
@@ -486,7 +486,7 @@ SET_ATTR_SIZE(struct stifb_info *fb, int width, int height)
 }
 
 static void
-FINISH_ATTR_ACCESS(struct stifb_info *fb) 
+FINISH_ATTR_ACCESS(struct stifb_info *fb)
 {
 	SETUP_HW(fb);
 	WRITE_WORD(0x00000000, fb, REG_12);
@@ -499,7 +499,7 @@ elkSetupPlanes(struct stifb_info *fb)
 	SETUP_FB(fb);
 }
 
-static void 
+static void
 ngleSetupAttrPlanes(struct stifb_info *fb, int BufferNumber)
 {
 	SETUP_ATTR_ACCESS(fb, BufferNumber);
@@ -519,7 +519,7 @@ rattlerSetupPlanes(struct stifb_info *fb)
 	 * read mask register for overlay planes, not image planes).
 	 */
 	CRX24_SETUP_RAMDAC(fb);
-    
+
 	/* change fb->id temporarily to fool SETUP_FB() */
 	saved_id = fb->id;
 	fb->id = CRX24_OVERLAY_PLANES;
@@ -565,7 +565,7 @@ setNgleLutBltCtl(struct stifb_info *fb, int offsetWithinLut, int length)
 	lutBltCtl.all           = 0x80000000;
 	lutBltCtl.fields.length = length;
 
-	switch (fb->id) 
+	switch (fb->id)
 	{
 	case S9000_ID_A1439A:		/* CRX24 */
 		if (fb->var.bits_per_pixel == 8) {
@@ -576,12 +576,12 @@ setNgleLutBltCtl(struct stifb_info *fb, int offsetWithinLut, int length)
 			lutBltCtl.fields.lutOffset = 0 * 256;
 		}
 		break;
-		
+
 	case S9000_ID_ARTIST:
 		lutBltCtl.fields.lutType = NGLE_CMAP_INDEXED0_TYPE;
 		lutBltCtl.fields.lutOffset = 0 * 256;
 		break;
-		
+
 	default:
 		lutBltCtl.fields.lutType = NGLE_CMAP_INDEXED0_TYPE;
 		lutBltCtl.fields.lutOffset = 0;
@@ -596,7 +596,7 @@ setNgleLutBltCtl(struct stifb_info *fb, int offsetWithinLut, int length)
 #endif
 
 static NgleLutBltCtl
-setHyperLutBltCtl(struct stifb_info *fb, int offsetWithinLut, int length) 
+setHyperLutBltCtl(struct stifb_info *fb, int offsetWithinLut, int length)
 {
 	NgleLutBltCtl lutBltCtl;
 
@@ -633,7 +633,7 @@ static void hyperUndoITE(struct stifb_info *fb)
 
 	/* Hardware setup for full-depth write to "magic" location */
 	GET_FIFO_SLOTS(fb, nFreeFifoSlots, 7);
-	NGLE_QUICK_SET_DST_BM_ACCESS(fb, 
+	NGLE_QUICK_SET_DST_BM_ACCESS(fb,
 		BA(IndexedDcd, Otc04, Ots08, AddrLong,
 		BAJustPoint(0), BINovly, BAIndexBase(0)));
 	NGLE_QUICK_SET_IMAGE_BITMAP_OP(fb,
@@ -653,13 +653,13 @@ static void hyperUndoITE(struct stifb_info *fb)
 	NGLE_UNLOCK(fb);
 }
 
-static void 
+static void
 ngleDepth8_ClearImagePlanes(struct stifb_info *fb)
 {
 	/* FIXME! */
 }
 
-static void 
+static void
 ngleDepth24_ClearImagePlanes(struct stifb_info *fb)
 {
 	/* FIXME! */
@@ -675,7 +675,7 @@ ngleResetAttrPlanes(struct stifb_info *fb, unsigned int ctlPlaneReg)
 	NGLE_LOCK(fb);
 
 	GET_FIFO_SLOTS(fb, nFreeFifoSlots, 4);
-	NGLE_QUICK_SET_DST_BM_ACCESS(fb, 
+	NGLE_QUICK_SET_DST_BM_ACCESS(fb,
 				     BA(IndexedDcd, Otc32, OtsIndirect,
 					AddrLong, BAJustPoint(0),
 					BINattr, BAIndexBase(0)));
@@ -713,22 +713,22 @@ ngleResetAttrPlanes(struct stifb_info *fb, unsigned int ctlPlaneReg)
 	/**** Finally, set the Control Plane Register back to zero: ****/
 	GET_FIFO_SLOTS(fb, nFreeFifoSlots, 1);
 	NGLE_QUICK_SET_CTL_PLN_REG(fb, 0);
-	
+
 	NGLE_UNLOCK(fb);
 }
-    
+
 static void
 ngleClearOverlayPlanes(struct stifb_info *fb, int mask, int data)
 {
 	int nFreeFifoSlots = 0;
 	u32 packed_dst;
 	u32 packed_len;
-    
+
 	NGLE_LOCK(fb);
 
 	/* Hardware setup */
 	GET_FIFO_SLOTS(fb, nFreeFifoSlots, 8);
-	NGLE_QUICK_SET_DST_BM_ACCESS(fb, 
+	NGLE_QUICK_SET_DST_BM_ACCESS(fb,
 				     BA(IndexedDcd, Otc04, Ots08, AddrLong,
 					BAJustPoint(0), BINovly, BAIndexBase(0)));
 
@@ -736,23 +736,23 @@ ngleClearOverlayPlanes(struct stifb_info *fb, int mask, int data)
 
         NGLE_REALLY_SET_IMAGE_FG_COLOR(fb, data);
         NGLE_REALLY_SET_IMAGE_PLANEMASK(fb, mask);
-    
+
         packed_dst = 0;
         packed_len = (fb->info.var.xres << 16) | fb->info.var.yres;
         NGLE_SET_DSTXY(fb, packed_dst);
-    
-        /* Write zeroes to overlay planes */		       
+
+	/* Write zeroes to overlay planes */
 	NGLE_QUICK_SET_IMAGE_BITMAP_OP(fb,
 				       IBOvals(RopSrc, MaskAddrOffset(0),
 					       BitmapExtent08, StaticReg(0),
 					       DataDynamic, MaskOtc, BGx(0), FGx(0)));
-		       
+
         SET_LENXY_START_RECFILL(fb, packed_len);
 
 	NGLE_UNLOCK(fb);
 }
 
-static void 
+static void
 hyperResetPlanes(struct stifb_info *fb, int enable)
 {
 	unsigned int controlPlaneReg;
@@ -783,7 +783,7 @@ hyperResetPlanes(struct stifb_info *fb, int enable)
 	        ngleClearOverlayPlanes(fb, 0xff, 255);
 
 		/**************************************************
-		 ** Also need to counteract ITE settings 
+		 ** Also need to counteract ITE settings
 		 **************************************************/
 		hyperUndoITE(fb);
 		break;
@@ -803,13 +803,13 @@ hyperResetPlanes(struct stifb_info *fb, int enable)
 		ngleResetAttrPlanes(fb, controlPlaneReg);
 		break;
     	}
-	
+
 	NGLE_UNLOCK(fb);
 }
 
 /* Return pointer to in-memory structure holding ELK device-dependent ROM values. */
 
-static void 
+static void
 ngleGetDeviceRomData(struct stifb_info *fb)
 {
 #if 0
@@ -821,7 +821,7 @@ XXX: FIXME: !!!
 	char	*pCard8;
 	int	i;
 	char	*mapOrigin = NULL;
-    
+
 	int romTableIdx;
 
 	pPackedDevRomData = fb->ngle_rom;
@@ -888,7 +888,7 @@ SETUP_HCRX(struct stifb_info *fb)
 
 	/* Initialize Hyperbowl registers */
 	GET_FIFO_SLOTS(fb, nFreeFifoSlots, 7);
-	
+
 	if (IS_24_DEVICE(fb)) {
 		hyperbowl = (fb->info.var.bits_per_pixel == 32) ?
 			HYPERBOWL_MODE01_8_24_LUT0_TRANSPARENT_LUT1_OPAQUE :
@@ -897,9 +897,9 @@ SETUP_HCRX(struct stifb_info *fb)
 		/* First write to Hyperbowl must happen twice (bug) */
 		WRITE_WORD(hyperbowl, fb, REG_40);
 		WRITE_WORD(hyperbowl, fb, REG_40);
-		
+
 		WRITE_WORD(HYPERBOWL_MODE2_8_24, fb, REG_39);
-		
+
 		WRITE_WORD(0x014c0148, fb, REG_42); /* Set lut 0 to be the direct color */
 		WRITE_WORD(0x404c4048, fb, REG_43);
 		WRITE_WORD(0x034c0348, fb, REG_44);
@@ -990,7 +990,7 @@ stifb_setcolreg(u_int regno, u_int red, u_int green,
 				0,	/* Offset w/i LUT */
 				256);	/* Load entire LUT */
 		NGLE_BINC_SET_SRCADDR(fb,
-				NGLE_LONG_FB_ADDRESS(0, 0x100, 0)); 
+				NGLE_LONG_FB_ADDRESS(0, 0x100, 0));
 				/* 0x100 is same as used in WRITE_IMAGE_COLOR() */
 		START_COLORMAPLOAD(fb, lutBltCtl.all);
 		SETUP_FB(fb);
@@ -1028,7 +1028,7 @@ stifb_blank(int blank_mode, struct fb_info *info)
 		ENABLE_DISABLE_DISPLAY(fb, enable);
 		break;
 	}
-	
+
 	SETUP_FB(fb);
 	return 0;
 }
@@ -1114,15 +1114,15 @@ stifb_init_display(struct stifb_info *fb)
 
 	/* HCRX specific initialization */
 	SETUP_HCRX(fb);
-	
+
 	/*
 	if (id == S9000_ID_HCRX)
 		hyperInitSprite(fb);
 	else
 		ngleInitSprite(fb);
 	*/
-	
-	/* Initialize the image planes. */ 
+
+	/* Initialize the image planes. */
         switch (id) {
 	 case S9000_ID_HCRX:
 	    hyperResetPlanes(fb, ENABLE);
@@ -1194,7 +1194,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	fb = kzalloc(sizeof(*fb), GFP_ATOMIC);
 	if (!fb)
 		return -ENOMEM;
-	
+
 	info = &fb->info;
 
 	/* set struct to a known state */
@@ -1235,7 +1235,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 			dev_name, fb->id);
 		goto out_err0;
 	}
-	
+
 	/* default to 8 bpp on most graphic chips */
 	bpp = 8;
 	xres = sti_onscreen_x(fb->sti);
@@ -1256,7 +1256,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 		fb->id = S9000_ID_A1659A;
 		break;
 	case S9000_ID_TIMBER:	/* HP9000/710 Any (may be a grayscale device) */
-		if (strstr(dev_name, "GRAYSCALE") || 
+		if (strstr(dev_name, "GRAYSCALE") ||
 		    strstr(dev_name, "Grayscale") ||
 		    strstr(dev_name, "grayscale"))
 			var->grayscale = 1;
@@ -1295,16 +1295,16 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	case CRT_ID_VISUALIZE_EG:
 	case S9000_ID_ARTIST:	/* Artist */
 		break;
-	default: 
+	default:
 #ifdef FALLBACK_TO_1BPP
-	       	printk(KERN_WARNING 
+		printk(KERN_WARNING
 			"stifb: Unsupported graphics card (id=0x%08x) "
 				"- now trying 1bpp mode instead\n",
 			fb->id);
 		bpp = 1;	/* default to 1 bpp */
 		break;
 #else
-	       	printk(KERN_WARNING 
+		printk(KERN_WARNING
 			"stifb: Unsupported graphics card (id=0x%08x) "
 				"- skipping.\n",
 			fb->id);
@@ -1320,11 +1320,11 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	fix->line_length = (fb->sti->glob_cfg->total_x * bpp) / 8;
 	if (!fix->line_length)
 		fix->line_length = 2048; /* default */
-	
+
 	/* limit fbsize to max visible screen size */
 	if (fix->smem_len > yres*fix->line_length)
 		fix->smem_len = ALIGN(yres*fix->line_length, 4*1024*1024);
-	
+
 	fix->accel = FB_ACCEL_NONE;
 
 	switch (bpp) {
@@ -1350,7 +1350,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	    default:
 		break;
 	}
-	
+
 	var->xres = var->xres_virtual = xres;
 	var->yres = var->yres_virtual = yres;
 	var->bits_per_pixel = bpp;
@@ -1379,7 +1379,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 				fix->smem_start, fix->smem_start+fix->smem_len);
 		goto out_err2;
 	}
-		
+
 	if (!request_mem_region(fix->mmio_start, fix->mmio_len, "stifb mmio")) {
 		printk(KERN_ERR "stifb: cannot reserve sti mmio region 0x%04lx-0x%04lx\n",
 				fix->mmio_start, fix->mmio_start+fix->mmio_len);
@@ -1393,11 +1393,11 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 
 	fb_info(&fb->info, "%s %dx%d-%d frame buffer device, %s, id: %04x, mmio: 0x%04lx\n",
 		fix->id,
-		var->xres, 
+		var->xres,
 		var->yres,
 		var->bits_per_pixel,
 		dev_name,
-		fb->id, 
+		fb->id,
 		fix->mmio_start);
 
 	return 0;
@@ -1426,7 +1426,7 @@ static int __init stifb_init(void)
 	struct sti_struct *sti;
 	struct sti_struct *def_sti;
 	int i;
-	
+
 #ifndef MODULE
 	char *option = NULL;
 
@@ -1438,7 +1438,7 @@ static int __init stifb_init(void)
 		printk(KERN_INFO "stifb: disabled by \"stifb=off\" kernel parameter\n");
 		return -ENXIO;
 	}
-	
+
 	def_sti = sti_get_rom(0);
 	if (def_sti) {
 		for (i = 1; i <= MAX_STI_ROMS; i++) {
@@ -1472,7 +1472,7 @@ stifb_cleanup(void)
 {
 	struct sti_struct *sti;
 	int i;
-	
+
 	for (i = 1; i <= MAX_STI_ROMS; i++) {
 		sti = sti_get_rom(i);
 		if (!sti)
@@ -1495,10 +1495,10 @@ int __init
 stifb_setup(char *options)
 {
 	int i;
-	
+
 	if (!options || !*options)
 		return 1;
-	
+
 	if (strncmp(options, "off", 3) == 0) {
 		stifb_disabled = 1;
 		options += 3;
-- 
2.40.0

