Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9B7B1EB3
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjI1NlI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjI1NlH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 09:41:07 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21C618F;
        Thu, 28 Sep 2023 06:41:02 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E2EA16C13E9;
        Thu, 28 Sep 2023 13:40:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4657C6C10E9;
        Thu, 28 Sep 2023 13:40:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1695908457; a=rsa-sha256;
        cv=none;
        b=g9ApNVDpXUw8NbiVPB91whx+A98KefOUdvwQ3MYgplXW6DoYam+sUPQAu91KxM6lXmAxXG
        4+lVY54zLzyyeGEiSaAH0MBOT3EuV9QBCa0z35Pjcv+ka5OdYgrOTPawDQ8X/6Hog0PECj
        +VCYPSQUjhUvfaQFeKTuTziLY1PYZ7zN0W2keRSHnvhhkZRSqGTT7nDSy/vr6QmB7kG2zE
        aKNFEeYHzAdw4/CP9pzCP/D5KIHZM+kN6o0Doinn8IGGWCCyXnD4WUM7GoCEAEmTdubvyH
        YNCN9PZ81xsNuE4W7RAYFXtAiT4RMIC4CXIiuJJCIv6I1MUs9hAY1OAbljCfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1695908457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=fV4Zxk0FhT7C3XEli4MGvFTPX5hp1XlfXjZMP4aD39E=;
        b=HoJv0cmylHUZA6FoIjPfBtY0ro3gzvVAMtGpG62BbF4JZKhTFuAeXbbMMWrMRmmHLMWbC1
        Su1yYVFJnEg6+imcOYpfqRFBMKak44KKYR7GGJC1Y23rdaeyTn8Z1YRVOvAY8jdOJGmth6
        ki1bCHAvCi1kba0drAKEAC254cmoOeUVO95JQzn7aFe1bnyaEsN4EX9DQLOFMWoci1n9Fq
        KgwUoMt97N7Npdr93dzqm0EXiacL/gvbC8ECImymDcwm4f2YFI3iSlGTyH5WvxP5xNjV4m
        qBqAkSJSA/OCTfaTx6sj6Uvr+90EujW3AM732SSUMEeK1om25hJK4lnP9RI4jA==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-ftkct;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Illegal: 128ccf8d5bc7bb01_1695908457686_874718514
X-MC-Loop-Signature: 1695908457686:2815361285
X-MC-Ingress-Time: 1695908457686
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.140.241 (trex/6.9.1);
        Thu, 28 Sep 2023 13:40:57 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4RxF481GpZzLJ;
        Thu, 28 Sep 2023 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1695908457;
        bh=fV4Zxk0FhT7C3XEli4MGvFTPX5hp1XlfXjZMP4aD39E=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=YX3pGd+sUWu1zeeF2pqWBMRrJZeNQkOmmn70Mqq6Iw782HyjKK/rQbp90x0CM28MQ
         ORUsj1thJvkFcftFmXRFJgwcTgcZAUIZnM8TWQkBbOnsfu3mrIjHTt1mt7DmYtaeo+
         YA/JI9YuN/kkMCRAeJLVbjheB8a558IPuxjyzgYK1d4QDcG4sNAI3j9bKO3NwAPGWw
         xjMHvl+rpIZEnI4KMbpxd8720EKSNF/OzV/vX425Rpme0SB+CUYaGU/7bSv2i+dXCK
         9ho7aXqOGPZPB7rqpNc5GGz+/Yg4v0H+teJQiEal+h5fLIp3hcmE3uZhGbuxwl2OWx
         hgJkWw+wEHVfg==
Date:   Thu, 28 Sep 2023 06:40:53 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dvhart@infradead.org, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, steve.shaw@intel.com,
        marko.makela@mariadb.com, andrei.artemev@intel.com
Subject: Re: futex2 numa stuff
Message-ID: <zhd6njnv63lithg5yetvyniwt34wcltxa5huk4ustp7j7pf2na@6v6qehyb3w3g>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>, 
        tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com, 
        dvhart@infradead.org, andrealmeid@igalia.com, 
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
        linux-arch@vger.kernel.org, malteskarupke@web.de, steve.shaw@intel.com, 
        marko.makela@mariadb.com, andrei.artemev@intel.com
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230922200120.011184118@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922200120.011184118@infradead.org>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 22 Sep 2023, Peter Zijlstra wrote:

>Hi!
>
>Updated version of patch 15/15 and a few extra patches for testing the
>FUTEX2_NUMA bits. The last patch (17/15) should never be applied for anything
>you care about and exists purely because I'm too lazy to generate actual
>hash-bucket contention.
>
>On my 2 node IVB-EP:
>
> $ echo FUTEX_SQUASH > /debug/sched/features
>
>Effectively reducing each node to 1 bucket.
>
> $ numactl -m0 -N0 ./futex_numa -c10 -t2 -n0 -N0 &
>   numactl -m1 -N1 ./futex_numa -c10 -t2 -n0 -N0
>
> ...
> contenders: 16154935
> contenders: 16202472
>
> $ numactl -m0 -N0 ./futex_numa -c10 -t2 -n0 -N0 &
>   numactl -m1 -N1 ./futex_numa -c10 -t2 -n0 -N1
>
> contenders: 48584991
> contenders: 48680560
>
>(loop counts, higher is better)
>
>Clearly showing how separating the hashes works.
>
>The first one runs 10 contenders on each node but forces the (numa) futex to
>hash to node 0 for both. This ensures all 20 contenders hash to the same
>bucket and *ouch*.
>
>The second one does the same, except now fully separates the nodes. Performance
>is much improved.
>
>Proving the per-node hashing actually works as advertised.

Very nice.
