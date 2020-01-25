Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29AA149701
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 18:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAYRrQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 12:47:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57361 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726448AbgAYRrP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 12:47:15 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00PHkXAB020640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 12:46:36 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 24C63420324; Sat, 25 Jan 2020 12:46:33 -0500 (EST)
Date:   Sat, 25 Jan 2020 12:46:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        x86@kernel.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Message-ID: <20200125174633.GN1108497@mit.edu>
References: <20200110145422.49141-1-broonie@kernel.org>
 <20200110155153.GG19453@zn.tnic>
 <20200110170559.GA304349@mit.edu>
 <20200120172627.GH6852@sirena.org.uk>
 <20200120175901.GB576@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120175901.GB576@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 06:59:01PM +0100, Borislav Petkov wrote:
> On Mon, Jan 20, 2020 at 05:26:27PM +0000, Mark Brown wrote:
> > I think the important thing here is that *someone* takes the patches.
> > We've now got Ted and Borislav both saying they're OK applying the
> > patches, an additional proposal that Andrew takes the patches, nobody
> > saying anything negative about applying the patches and yet the patches
> > are not applied.  The random tree sounds like a sensible enough tree to
> > take this so if Ted picks them up perhaps that's most sensible?
> 
> Yes, Ted, pls pick them up so that we're done with this.

I've picked them up and pushed them to the random tree.

     	    	    	       	       - Ted
