Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80BC4A7C46
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 01:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiBCAFf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Feb 2022 19:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiBCAFf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Feb 2022 19:05:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3575C061714;
        Wed,  2 Feb 2022 16:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xQooU1SeAas1UxR3X3UmWtN5zzl8oAjoZoNwYOADmzQ=; b=0tFyjfZigtDVzKO8NKFpEoPnFT
        +BCli90uB8dnN9Zb3T7haQ6WAVu9sc6f+G7578f6V+Ed7sq0Cjjc49k/pzlpBvQ2AIereclmGEPDp
        ON5m/YH0TmOLFNw8nDW0zc0VzUNFsfpDuhwNgjgmnGdkTPKnVx0HsdMG4TpsddoUk6Oc2Rhr8PlgS
        T9Se5iyhiWEbWWL6h4rbGDsFYCfK5t9NDYSf5hnBO2g+lA6lpIcMDGwHHhG2XV6ksmXUVKGwsRsiP
        V02pOQjQdh3QBDPMCF3VRYFQyMJVOfRTh0KfBezd9cKBgnMqC0/KCgCvhcdI2i173NI43neERYj8I
        mdDf5KHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFPcx-00H7nP-G0; Thu, 03 Feb 2022 00:05:31 +0000
Date:   Wed, 2 Feb 2022 16:05:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] Allocate module text and data separately
Message-ID: <YfscSzltd4UcZSCO@bombadil.infradead.org>
References: <cover.1643475473.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643475473.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 29, 2022 at 05:02:03PM +0000, Christophe Leroy wrote:
> This series allow architectures to request having modules data in
> vmalloc area instead of module area.
> 
> This is required on powerpc book3s/32 in order to set data non
> executable, because it is not possible to set executability on page
> basis, this is done per 256 Mbytes segments. The module area has exec
> right, vmalloc area has noexec. Without this change module data
> remains executable regardless of CONFIG_STRICT_MODULES_RWX.
> 
> This can also be useful on other powerpc/32 in order to maximize the
> chance of code being close enough to kernel core to avoid branch
> trampolines.
> 

This looks good, however I'd like to see Aaron's changes go in first,
and then yours. Aaron's changes still need to be tested by 0-day and I
need to finish review, but that's the order of how I'd prefer to see
changes merged / tested. I'll try to review his changes, dump them to
modules-next and then I'd like to trouble you to rebase ontop of that.

We should get all this tested early for the next release.

  Luis
