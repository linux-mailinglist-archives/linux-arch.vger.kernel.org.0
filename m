Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C243949E706
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 17:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiA0QFs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jan 2022 11:05:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51196 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiA0QFr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jan 2022 11:05:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 355801F3A9;
        Thu, 27 Jan 2022 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643299546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dff1mehmwy7lYfM1LSu0jEYbA2aOIzDLjNE1uhGynPU=;
        b=TlM0+ND9JjYYgVXvFx2Z+bO2cn/xPc2sEla+MbumW2dsnjVCspjF5/RPHLXN4NRS2VB39i
        afmZ+9Pkm5wrGeW+q66bEA3ojcrK1z9qThU7+PyLV2fXIaMfZCnnP8MBfC9AHZukPYjWGM
        eg2qPWoLk3vvoTmyaob7wgF4Qs1+qeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643299546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dff1mehmwy7lYfM1LSu0jEYbA2aOIzDLjNE1uhGynPU=;
        b=wKReWxNyajYBEJ/WJJM9qBosVQmFTr9W/2Yehih5rr39+B6Laphi6/utBYgwtcWNCTrAuR
        x9pJ8+gp64UKo5Aw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 16D81A3B84;
        Thu, 27 Jan 2022 16:05:45 +0000 (UTC)
Date:   Thu, 27 Jan 2022 17:05:45 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/7] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
In-Reply-To: <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
Message-ID: <alpine.LSU.2.21.2201271704470.26559@pobox.suse.cz>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu> <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> @@ -195,6 +208,9 @@ static void mod_tree_remove(struct module *mod)
>  {
>  	__mod_tree_remove(&mod->core_layout.mtn, &mod_tree);
>  	mod_tree_remove_init(mod);
> +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> +	__mod_tree_remove(&mod->core_layout.mtn, &mod_data_tree);

s/core_layout/data_layout/ ?

> +#endif
>  }

Miroslav
