Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4D69213F
	for <lists+linux-arch@lfdr.de>; Fri, 10 Feb 2023 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjBJO4u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 09:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjBJO4r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 09:56:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807770CFD
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2023 06:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676040956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+rg85xYSll7eP3Sf5GHRKpU1GokGp9XDi0j91yLtiE=;
        b=XPjtEHIRt8y7ImFUx3WsWcHgEppv4XCdJUS2K7n/ChefdllbRatf8k9+EeCwuRxYgSBV8U
        SOSfOIPMtSmefzISPXjZzS9Tot8HEsw6+NklIv5EJPc8H3yiLka7KHocOJJhXPJdeNQJEB
        nXqYma4ownhBnctXQNTzzEoiz765lRc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-365-bM22Kz8lNb-y2GD8icOLiQ-1; Fri, 10 Feb 2023 09:55:53 -0500
X-MC-Unique: bM22Kz8lNb-y2GD8icOLiQ-1
Received: by mail-qt1-f199.google.com with SMTP id s4-20020ac85284000000b003b849aa2cd6so3184156qtn.15
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2023 06:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+rg85xYSll7eP3Sf5GHRKpU1GokGp9XDi0j91yLtiE=;
        b=Jza5HHm/2J2GNoDjWnRxR/nCtf3tIyL/hWhJR65R//8Go7DcC0ClnBTq+ijA84pVtz
         JQs+otjAsNxRS0WXucI0Q7wMUB+dowioD3TuhJmBQka7y4IAVYSi4eUDezcqFXD/evug
         uK/LInN/IkPkO+wcg0Lx/H6qZxj6L9YvX+VHWbQIZdKSzfc7VXD0tr3yTAoZIG+aWxgG
         qR9igapGnUhfEa8CbNNU22+KKsJr0YAoMDVIv4ILlX3GmGXP9EO6CU8Jqvu1rBZgoEyF
         mhlF0NX3lbgEVXfXNPESwF0Kx7i9EHlaB5sz89pbA6+hAXMVKsumFzCcqgJODqgSlY0t
         AxEg==
X-Gm-Message-State: AO0yUKWM8IfxW03q6LNBSICz15w4Nf3slpp+NKDVwd2McTH0rn7gSSkT
        qLJW8LExdDq0MXsouXlWRRkUkv9SNl+KaX9nUAsW7nzPgCHTHZlUrknH2aIeplwPYGkU8iYXzDw
        bllcpRz9y2YlCv9Cd24UOdA==
X-Received: by 2002:ac8:5955:0:b0:3b3:7d5:a752 with SMTP id 21-20020ac85955000000b003b307d5a752mr26834092qtz.50.1676040952550;
        Fri, 10 Feb 2023 06:55:52 -0800 (PST)
X-Google-Smtp-Source: AK7set/IAOXvCvxAJe1QVvAocUsN8WugW1iNym2GUKlBrMHZnHFLP+SYPzzktfBcL8E2KyHQV7ULTw==
X-Received: by 2002:ac8:5955:0:b0:3b3:7d5:a752 with SMTP id 21-20020ac85955000000b003b307d5a752mr26834042qtz.50.1676040952267;
        Fri, 10 Feb 2023 06:55:52 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-178-85.web.vodafone.de. [109.43.178.85])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87cac000000b003b9bc00c2f1sm3370579qtv.94.2023.02.10.06.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:55:51 -0800 (PST)
Message-ID: <2344ac16-781e-8bfa-ec75-e71df0f3ed28@redhat.com>
Date:   Fri, 10 Feb 2023 15:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 03/14] Move COMPAT_ATM_ADDPARTY to net/atm/svc.c
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     viro@zeniv.linux.org.uk, aishchuk@linux.vnet.ibm.com,
        aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org,
        acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com,
        chris@zankel.net, dave@sr71.net, dyoung@redhat.com,
        drysdale@google.com, ebiederm@xmission.com, geoff@infradead.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org,
        iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org,
        josh@joshtriplett.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com,
        a.p.zijlstra@chello.nl, tglx@linutronix.de, vgoyal@redhat.com,
        x86@kernel.org, arnd@arndb.de, dhowells@redhat.com,
        peterz@infradead.org, netdev@vger.kernel.org
References: <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
 <1447119071-19392-1-git-send-email-palmer@dabbelt.com>
 <1447119071-19392-4-git-send-email-palmer@dabbelt.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <1447119071-19392-4-git-send-email-palmer@dabbelt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/11/2015 02.31, Palmer Dabbelt wrote:
> This used to be behind an #ifdef COMPAT_COMPAT, so most of userspace
> wouldn't have seen the definition before.  Unfortunately this header
> file became visible to userspace, so the definition has instead been
> moved to net/atm/svc.c (the only user).
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
> Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
> ---
>   include/uapi/linux/atmdev.h | 4 ----
>   net/atm/svc.c               | 5 +++++
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/atmdev.h b/include/uapi/linux/atmdev.h
> index 93e0ec0..3dcec70 100644
> --- a/include/uapi/linux/atmdev.h
> +++ b/include/uapi/linux/atmdev.h
> @@ -100,10 +100,6 @@ struct atm_dev_stats {
>   					/* use backend to make new if */
>   #define ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct atm_iobuf)
>    					/* add party to p2mp call */
> -#ifdef CONFIG_COMPAT
> -/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
> -#define COMPAT_ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct compat_atm_iobuf)
> -#endif
>   #define ATM_DROPPARTY 	_IOW('a', ATMIOC_SPECIAL+5,int)
>   					/* drop party from p2mp call */
>   
> diff --git a/net/atm/svc.c b/net/atm/svc.c
> index 3fa0a9e..9e2e6ef 100644
> --- a/net/atm/svc.c
> +++ b/net/atm/svc.c
> @@ -27,6 +27,11 @@
>   #include "signaling.h"
>   #include "addr.h"
>   
> +#ifdef CONFIG_COMPAT
> +/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
> +#define COMPAT_ATM_ADDPARTY _IOW('a', ATMIOC_SPECIAL+4, struct compat_atm_iobuf)
> +#endif
> +
>   static int svc_create(struct net *net, struct socket *sock, int protocol,
>   		      int kern);
>   

  Hi!

The CONFIG_* switch is still there in the atmdev.h uapi header ... could 
somebody please pick this patch up to fix it?

  Thanks,
   Thomas

