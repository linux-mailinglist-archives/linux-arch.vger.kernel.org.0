Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503FA1B7817
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgDXOKk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 10:10:40 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:57869 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgDXOKk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 10:10:40 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B8F5A3000467A;
        Fri, 24 Apr 2020 16:10:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9335B70E94E; Fri, 24 Apr 2020 16:10:37 +0200 (CEST)
Date:   Fri, 24 Apr 2020 16:10:37 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        vilhelm.gray@gmail.com, arnd@arndb.de, linus.walleij@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200424141037.ersebbfe7xls37be@wunner.de>
References: <20200424122521.GA5552@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424122521.GA5552@syed>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
> +static inline void bitmap_set_value(unsigned long *map,
> +				    unsigned long value,
> +				    unsigned long start, unsigned long nbits)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +	const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> +	const unsigned long space = ceiling - start;
> +
> +	value &= GENMASK(nbits - 1, 0);
> +
> +	if (space >= nbits) {
> +		map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> +		map[index] |= value << offset;
> +	} else {
> +		map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +		map[index] |= value << offset;
> +		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +		map[index + 1] |= (value >> space);
> +	}
> +}

Sorry but what's the advantage of using this complicated function
as a replacement for the much simpler bitmap_set_value8()?

The drivers calling bitmap_set_value8() *know* that 8-bit accesses
are possible and take advantage of that knowledge by using a small,
speed-optimized function.  Replacing that with a more complicated
(potentially less performant) function doesn't seem to be a step
forward.

Thanks,

Lukas
