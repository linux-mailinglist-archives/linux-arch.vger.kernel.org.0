Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38ED1AB4
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfJIVS6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 17:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJIVS6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Oct 2019 17:18:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7C420B7C;
        Wed,  9 Oct 2019 21:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570655936;
        bh=J/UoD8TI8r2PBv1hXoDAUnvePVV2cHTJo4SSSOlvQS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CJOqXT1XwlBfVttI7DYPGvW2Jevkihy44Tves3loSgg+2No5LLHJwR5E2VQLHHex7
         ayk23kjS13Kei0/AcZ6eZn/SKW03QpiTYpeZtE1NPQ4lSiYLuWei96qaa2o4pq9AD7
         vzOEBBXiawhBVDCShGgzDBq1ExUBLHM5C8PDVpts=
Date:   Wed, 9 Oct 2019 14:18:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v18 01/14] bitops: Introduce the for_each_set_clump8
 macro
Message-Id: <20191009141855.310f1fa8bde58df0df27b8f0@linux-foundation.org>
In-Reply-To: <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570641097.git.vilhelm.gray@gmail.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
        <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570641097.git.vilhelm.gray@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed,  9 Oct 2019 13:14:37 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
> 
> ...
>  
> +#define for_each_set_clump8(start, clump, bits, size) \
> +	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> +	     (start) < (size); \
> +	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
> +

It wouldn't hurt to give this some documentation.  In kerneldoc form, I
guess.
