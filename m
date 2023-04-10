Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEBF6DC255
	for <lists+linux-arch@lfdr.de>; Mon, 10 Apr 2023 03:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDJBb6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Apr 2023 21:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDJBb6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Apr 2023 21:31:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6886272D;
        Sun,  9 Apr 2023 18:31:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso3081449pjp.5;
        Sun, 09 Apr 2023 18:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681090316; x=1683682316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLwvq29JwSIBBYrW4Isd+U0FFmgKDUr1oqbZPE8w1Ss=;
        b=WKRMfFedjP5ddZMGsOzbCdVYKjCqlZnsKmxnnPw2qLtc+vvr3+JgWYufAIBCVWApfw
         bjX3XnZGTJ4Nb6b7MDHDWZaB4N4fMwdQo6tmrLDmY9Bo8NndeHi3DaYEJvLaECZ9MKlG
         a7NficR9AdtQqTvGXtuL+8Ijx6X7fEMeQj6zEmKcIRtCNQxbHBdIt0WpSSDtmKy+HZ6V
         l05J+Tf12/fpv12A+Naoap18xZo72XuejjElz+TlRBiE0Xf7Jc+oPMqmjBUork2K8pqc
         grHL1yyPrnFox2Y7K17wKKiJq/bYa2MBneQSXiZEvEZrRZUktZqta+jP/XAx8aml8v23
         XFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681090316; x=1683682316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLwvq29JwSIBBYrW4Isd+U0FFmgKDUr1oqbZPE8w1Ss=;
        b=BQadNTi6AdRjqfTxDm7ZCz7wIXqsy2mI3NGwvw8fqJvAsaGngMozbQGOSWCiD2w6yu
         PTJ8QZ9br3DNoz5dCqLIQrFkvD0OwW3iU2qRPOIASdXzTglOhma6C5TdPFoGfK/6z8y1
         CjZK+0LHhgnxN55DaPZyxQrseokFbcjur/588ngiqjV+hR/Jm/rSw3ZzOMufcFd7Fj2f
         v42huXdMaMReU4sBc2vM+qWnxiOwXrWKBnAZTBp79y8SgPc0QRu2tNDf/DvPzNvgdtzv
         T2lvyopNSMeEHQ7TkbOkutmwRSBwxK0pyRMEO/aK70fBdCB9Pqoyi8HAKI1+iKS20iQz
         zMtQ==
X-Gm-Message-State: AAQBX9emIB7ZZEY8SiIZt/txjH1Z8cKIrMJJjzSOAwIfj/ntjNQ8l0Rq
        CaMDcaAWc33T689ik8wQ+Bk=
X-Google-Smtp-Source: AKy350adz1kb7JahPlYOAO2PqxvyuQm+oHmSvdfrjXXQmldWN/GjLOAyT3H3pQ0Q7E1BxxafFzFnxg==
X-Received: by 2002:a17:903:22c4:b0:1a2:70ed:6cd9 with SMTP id y4-20020a17090322c400b001a270ed6cd9mr13860468plg.22.1681090315981;
        Sun, 09 Apr 2023 18:31:55 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b001a216d44440sm6430968plk.200.2023.04.09.18.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 18:31:55 -0700 (PDT)
Message-ID: <9c21f8ec-4f1d-9658-bf5b-682be16d9321@gmail.com>
Date:   Mon, 10 Apr 2023 10:31:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] tools: memory-model: Rename litmus test to avoid
 confusion with similar-named test
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230409044823.775760-1-joel@joelfernandes.org>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230409044823.775760-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Joel,

On Sun,  9 Apr 2023 04:48:22 +0000, Joel Fernandes (Google) wrote:
> In order to differentiate the test
> Z6.0+pooncelock+poonceLock+pombonce.litmus from another test that only
> differs by a capital L, the following file has been renamed:
> 
> renamed: litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus ->
> litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus
> 
> This change should help avoid confusion between the two tests.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  ...mbonce.litmus => Z6.0+pooncelock+pooncelockmb+pombonce.litmus} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+pooncelockmb+pombonce.litmus} (100%)
> 
> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus
> similarity index 100%
> rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus

I must say simply changing the file name is only part of the job.
You need to update comments/docs as well.

There are 4 hits after this patch is applied:

$ find . -type f -exec grep -nH --null -F -e Z6.0+pooncelock+poonceLock \{\} +
./tools/memory-model/Documentation/locking.txt187:	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
./tools/memory-model/Documentation/recipes.txt162:	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
./tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus1:C Z6.0+pooncelock+poonceLock+pombonce
./tools/memory-model/litmus-tests/README152:Z6.0+pooncelock+poonceLock+pombonce.litmus

        Thanks, Akira
