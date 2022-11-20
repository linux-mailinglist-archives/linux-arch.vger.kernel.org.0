Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D770063139A
	for <lists+linux-arch@lfdr.de>; Sun, 20 Nov 2022 12:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKTLT0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Nov 2022 06:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKTLTY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Nov 2022 06:19:24 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4326DFF0;
        Sun, 20 Nov 2022 03:19:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b21so8236135plc.9;
        Sun, 20 Nov 2022 03:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dk2pp7LLJq5cYCEARrY8mNp98J6nPrm47A67lY2SBxI=;
        b=EAY1BKYUCpclYtEnAFB3EivaJxfS5ZUqUaC73N873rEFhSm4WEUId3WSzFin+Eem8R
         QwWmGein6XXRInoU9zaqMit4e5ZeRlUFia3ebCcFIKvzVOqMOYYHacVBaD1fq6XZjBo6
         7+JNS34ZTBer5iuRncPszKzX1BItFzJO2wT9UrKj4UgB6XPtM6qYu8koEYEoa8m0TMWN
         B50bL47XOg9mu8oyp8mKQO2Aayn5fAHgSmbH/t/+chvsULDxF0+IpwPvWZwRNb9X0i5U
         qHi5CHnQXigny5M/n1JVyP4MENY7FfYwAuGM8qq8FjNvPYWcLZ0XQC4Dgp96aZCDCm3B
         idMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk2pp7LLJq5cYCEARrY8mNp98J6nPrm47A67lY2SBxI=;
        b=ui2OL0VwZgwkTtlDhAvwKT6EAdrZ9laz0Ik1TMcNDX6REv8WehJ9BxXUbppKeBzY7r
         ZEAO062/ANpKe2FImM5ZUr1Kz2tYZjTlYCcgUSSjbirfgkpYJwKIlyVzFn3e7viEPJgl
         w+o++zzKHNa9w1jeODaI2LYIH6UixPTYo2gcUBs0lTCc6ZFDXnB8EN+shccoLSq8jD62
         +kPeLSw82J8svm5ObJF14RW0WAFAEeKyMQw4S4MCnu1dliBLrosIxFB2KCABuKBeBAMA
         CVom7USvRLi1cPz0RXLpxj++By4Had4GKoibSWiH1fR3e6iAl2CGvHmmN/4WnUqYyPpm
         XVTQ==
X-Gm-Message-State: ANoB5pn3zpod6pPtFbzkvVxQ6TpqyI7REk1Z7Lf7nbDwiL6wziG/FiGm
        vaVAcDQSjDNQwnuAuWuzWlM=
X-Google-Smtp-Source: AA0mqf5EF0alTRmGujnB5HXaaXqBFj5BZS2ywQ79K/3weWK3ae7ZZjziJNCt7E2Lpqn0laUWguGYLg==
X-Received: by 2002:a17:90a:8a82:b0:210:7cd5:db0e with SMTP id x2-20020a17090a8a8200b002107cd5db0emr16464147pjn.30.1668943163154;
        Sun, 20 Nov 2022 03:19:23 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78f30000000b0057280487af3sm6372948pfr.203.2022.11.20.03.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:19:22 -0800 (PST)
Message-ID: <d0d2ea9e-9345-f462-b15b-edf31024f7d5@gmail.com>
Date:   Sun, 20 Nov 2022 20:19:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] tools/memory-model: Use "grep -E" instead of "egrep"
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <1668823998-28548-1-git-send-email-yangtiezhu@loongson.cn>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <1668823998-28548-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 19 Nov 2022 10:13:18 +0800, Tiezhu Yang wrote:
> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
> 	egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the related file to use "grep -E" instead.
> 
>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/memory-model`
> 
> Here are the steps to install the latest grep:
> 
>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>   tar xf grep-3.8.tar.gz
>   cd grep-3.8 && ./configure && make
>   sudo make install
>   export PATH=/usr/local/bin:$PATH
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/memory-model/scripts/checkghlitmus.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
> index 6589fbb..f72816a 100755
> --- a/tools/memory-model/scripts/checkghlitmus.sh
> +++ b/tools/memory-model/scripts/checkghlitmus.sh
> @@ -35,13 +35,13 @@ fi
>  # Create a list of the C-language litmus tests previously run.
>  ( cd $LKMM_DESTDIR; find litmus -name '*.litmus.out' -print ) |
>  	sed -e 's/\.out$//' |
> -	xargs -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
> +	xargs -r grep -E -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
>  	xargs -r grep -L "^P${LKMM_PROCS}"> $T/list-C-already
>  
>  # Create a list of C-language litmus tests with "Result:" commands and
>  # no more than the specified number of processes.
>  find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C
> -xargs < $T/list-C -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
> +xargs < $T/list-C -r grep -E -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
>  xargs < $T/list-C-result -r grep -L "^P${LKMM_PROCS}" > $T/list-C-result-short
>  
>  # Form list of tests without corresponding .litmus.out files

Looks good to me.

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

Paul, JFYI, this patch doesn't apply cleanly on -rcu dev due to
a couple of changes in the lkmm-dev.2022.10.18c branch.

        Thanks, Akira
