Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0200F10B93A
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2019 21:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfK0UvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Nov 2019 15:51:20 -0500
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:46189 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730453AbfK0UvU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Nov 2019 15:51:20 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2019 15:51:19 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 3D8BD812268B
        for <linux-arch@vger.kernel.org>; Wed, 27 Nov 2019 20:42:42 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1F9C6837F24D;
        Wed, 27 Nov 2019 20:42:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3874:4321:5007:10004:10400:10848:11026:11658:11914:12294:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30029:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: screw31_34379b223a41f
X-Filterd-Recvd-Size: 1759
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Nov 2019 20:42:38 +0000 (UTC)
Message-ID: <80168e5bebedeb64e999ed11d8479846270bd3d7.camel@perches.com>
Subject: Re: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arch@vger.kernel.org
Date:   Wed, 27 Nov 2019 12:42:12 -0800
In-Reply-To: <20191127175051.1351346-1-jim.cromie@gmail.com>
References: <20191127175051.1351346-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2019-11-27 at 10:50 -0700, Jim Cromie wrote:
> dyndbg populates its callsite info into __verbose section, change that
> to a more specific and descriptive name, __dyndbg.
[]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
[]
> @@ -1040,7 +1040,7 @@ static int __init dynamic_debug_init(void)
>  	ddebug_init_success = 1;
>  	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",

This format should also change verbose to dyndbg
Maybe the ddebug word too

>  		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
> -		 verbose_bytes + (int)(__stop___verbose - __start___verbose));
> +		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
>  
>  	/* apply ddebug_query boot param, dont unload tables on err */
>  	if (ddebug_setup_string[0] != '\0') {

