Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023DC6BAE4C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjCOK4x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCOK4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:56:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E91054CB4;
        Wed, 15 Mar 2023 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/S0vNrLIUD8lAT5X8cd0AhBkLUpDy8HKFkOZf2dz0lU=; b=upPPZZhZiiBnPBl8b7cxt6K/cv
        OoyhettmP0PXFD6v9JKwwovXWv3O+JT2qSDZpUK7oxyiP9PIzxTfyECAhD22+BJT3vrtL06wykR0T
        Iyw/dHWRThKOwDmd+/AcOqDeuRYRWzgqsPvTYXYkeCEJ9OV+nIM9pF8Gn5h3+7hX3hjMmeKCiqB9r
        5fqh0goMcS9LfNqi2rqqzJCexO9sX83yP4UrF7mA837d4M9e14krgReDiQPdE5Jf9yH2jP+TZhoGV
        y83GhCxKClLqDz/RnxvnKTn9KL/+vdbCcHrc/ycCjg3Yly4gfti5YSpRDXB+uTcFE4Tsl3KZovsG7
        kJO2NBFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45430)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pcOo1-00072q-Js; Wed, 15 Mar 2023 10:56:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pcOnz-0001KN-Es; Wed, 15 Mar 2023 10:56:27 +0000
Date:   Wed, 15 Mar 2023 10:56:27 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 08/36] arm: Implement the new page table range API
Message-ID: <ZBGkW3JEHq9ZpwgL@shell.armlinux.org.uk>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-9-willy@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:16AM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
> flush_icache_pages().  Change the PG_dcache_clear flag from being per-page
> to per-folio which makes __dma_page_dev_to_cpu() a bit more exciting.
> Also add flush_cache_pages(), even though this isn't used by generic code
> (yet?)
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
