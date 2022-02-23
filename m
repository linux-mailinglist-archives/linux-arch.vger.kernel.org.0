Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606154C1CBD
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 21:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbiBWUBO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 15:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiBWUBN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 15:01:13 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E3036B42
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:00:44 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id MxoSnoXxX41cbMxoSnhzlJ; Wed, 23 Feb 2022 21:00:42 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 23 Feb 2022 21:00:42 +0100
X-ME-IP: 90.126.236.122
Message-ID: <7ce2df48-b876-0c30-d003-32275c5a9f65@wanadoo.fr>
Date:   Wed, 23 Feb 2022 21:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 07/13] udp_tunnel: remove the usage of the list
 iterator after the loop
Content-Language: fr
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-8-jakobkoschel@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220217184829.1991035-8-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 17/02/2022 à 19:48, Jakob Koschel a écrit :
> The usage of node->dev after the loop body is a legitimate type
> confusion if the break was not hit. It will compare an undefined
> memory location with dev that could potentially be equal. The value
> of node->dev in this case could either be a random struct member of the
> head element or an out-of-bounds value.
> 
> Therefore it is more safe to use the found variable. With the
> introduction of speculative safe list iterator this check could be
> replaced with if (!node).
> 
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>   net/ipv4/udp_tunnel_nic.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index b91003538d87..c47f9fb36d29 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -842,11 +842,14 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
>   	 */
>   	if (info->shared) {
>   		struct udp_tunnel_nic_shared_node *node, *first;
> +		bool found = false;
>   
>   		list_for_each_entry(node, &info->shared->devices, list)
> -			if (node->dev == dev)
> +			if (node->dev == dev) {
> +				found = true;
>   				break;
> -		if (node->dev != dev)
> +			}
> +		if (!found)
>   			return;
>   
>   		list_del(&node->list);

Hi,

just in case, see Dan Carpeter's patch for the same issue with another 
fix at:
https://lore.kernel.org/kernel-janitors/20220222134251.GA2271@kili/

CJ
