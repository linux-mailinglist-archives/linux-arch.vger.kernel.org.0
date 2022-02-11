Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B774B1FE5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347940AbiBKIFx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 03:05:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiBKIFw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 03:05:52 -0500
X-Greylist: delayed 1080 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 00:05:50 PST
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2FC9D69;
        Fri, 11 Feb 2022 00:05:50 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21B7dKQZ012095;
        Fri, 11 Feb 2022 01:39:21 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21B7dJjv012092;
        Fri, 11 Feb 2022 01:39:19 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 11 Feb 2022 01:39:19 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 04/12] powerpc: Prepare func_desc_t for refactorisation
Message-ID: <20220211073919.GW614@gate.crashing.org>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu> <86c393ce0a6f603f94e6d2ceca08d535f654bb23.1634457599.git.christophe.leroy@csgroup.eu> <202202101653.9128E58B84@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202101653.9128E58B84@keescook>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 04:54:52PM -0800, Kees Cook wrote:
> On Sun, Oct 17, 2021 at 02:38:17PM +0200, Christophe Leroy wrote:
(edited:)
> > +typedef struct {
> > +	unsigned long addr;
> > +} func_desc_t;
> >  
> >  static func_desc_t func_desc(unsigned long addr)
> >  {
> > +	return (func_desc_t){addr};

> There's only 1 element in the struct, so okay, but it hurt my eyes a
> little. I would have been happier with:
> 
> 	return (func_desc_t){ .addr = addr; };
> 
> But of course that also looks bonkers because it starts with "return".
> So no matter what I do my eyes bug out. ;)

The usual way to avoid convoluted constructs is to name more factors.
So:

static func_desc_t func_desc(unsigned long addr)
{
	func_desc_t desc = {};
	desc.addr = addr;
	return desc;
}


Segher
