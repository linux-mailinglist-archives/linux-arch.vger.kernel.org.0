Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCE28628C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgJGPrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgJGPrj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:47:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C8EC061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:47:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQBfC-0010tZ-5z; Wed, 07 Oct 2020 17:47:34 +0200
Message-ID: <486e080e64056189b5309bbcaec2ebf235d501a0.camel@sipsolutions.net>
Subject: Re: [RFC v7 10/21] um: nommu: memory handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:47:33 +0200
In-Reply-To: <de40a235d95ad582dae11741e272a5cf300384f2.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <de40a235d95ad582dae11741e272a5cf300384f2.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> 
>   * These operations must be provided by a host library or by the application
>   * itself.
>   *
> + * @mem_alloc - allocate memory
> + * @mem_free - free memory
> + *

Actual kernel-doc would be nicer.

> +	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +	memset((void *)empty_zero_page, 0, PAGE_SIZE);
> +
> +	{
> +		unsigned long zones_size[MAX_NR_ZONES] = {0, };

Hmm, what's with the extra scope?

johannes

