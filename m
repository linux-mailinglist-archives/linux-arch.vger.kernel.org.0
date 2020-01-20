Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7FC143131
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 18:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATR7I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 12:59:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATR7I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jan 2020 12:59:08 -0500
Received: from zn.tnic (p200300EC2F03FF0075FD4DB0C8DF3C59.dip0.t-ipconnect.de [IPv6:2003:ec:2f03:ff00:75fd:4db0:c8df:3c59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D4FA1EC08E5;
        Mon, 20 Jan 2020 18:59:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579543147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E8yvJahz8u60P3zYVn0P6etm4lyGGmfJf6bH0Xyy7nU=;
        b=XMd8vjuGkhMwuiJurJoolyqiOtsuPzlfQU9iSQRoOmrWlSkUGJb7hosQbL9t8FQ7PxTbpQ
        nn4Vc78yUd31Ad58e/FLUN/VcuvyrOQ2n3W2x0sz9j4qUl0ivg4dxbMn/3PvPE2AyqacLa
        OudmraXK5SPyti2iMRgwYV4piS2dsb8=
Date:   Mon, 20 Jan 2020 18:59:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        x86@kernel.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Message-ID: <20200120175901.GB576@zn.tnic>
References: <20200110145422.49141-1-broonie@kernel.org>
 <20200110155153.GG19453@zn.tnic>
 <20200110170559.GA304349@mit.edu>
 <20200120172627.GH6852@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120172627.GH6852@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 05:26:27PM +0000, Mark Brown wrote:
> I think the important thing here is that *someone* takes the patches.
> We've now got Ted and Borislav both saying they're OK applying the
> patches, an additional proposal that Andrew takes the patches, nobody
> saying anything negative about applying the patches and yet the patches
> are not applied.  The random tree sounds like a sensible enough tree to
> take this so if Ted picks them up perhaps that's most sensible?

Yes, Ted, pls pick them up so that we're done with this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
