Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF48A12A
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfHLOcp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 10:32:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33347 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHLOcp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Aug 2019 10:32:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so8769703pgn.0;
        Mon, 12 Aug 2019 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UB5d1qoKeXkAZIOi+pPzA6bZZuCbTNlVB/G/hoTvZU0=;
        b=OFrzc12lbP6MyY3Cg5o4aIfO5f9GDGzDQvz1BjDGCyOQa0H9pVMqALPWp7XOoNiZJ2
         ObPgy0imBpFYLsbuy95GGdQq5jddsKI5GY++ZCFmOvwMrPghUtHHHcLggXhCd+d3+qqZ
         YejwOQP5cCWEBx2OdfSBtSFw/1u+kp/a0Mgj2mWFkGUfN+afDMXy2IvPV92jj8E9Wa07
         3xNLoFsCvTCEkVNOIw+2uQqFBQnFrQpKWyZ2br4Hu20JQL0YEz7HQ96/LSpZHl4IWxyV
         8zjnYEPc1sruCAP3dBq+qwM2gMa2Vw9jutioKMMVFms6KpJn7Ol0mFgYp4zyPbgDy6HD
         Go9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UB5d1qoKeXkAZIOi+pPzA6bZZuCbTNlVB/G/hoTvZU0=;
        b=aXwHYKU3rujNNPPjzoRVdwP/FwWQomfNuvE1ka0nzxf/y4Pe8ug92ROBa7X9074Gqg
         7fzMVIb0FKPX19/T6OxuELolg4W+UoCEcQLPLa2LBXrZkZgqxR7b2sfZe4xgjubdRlAw
         o1Ax8zNcTrUZU2EOkx8ZcRh/s5dVHqJTIol4gDPCLHHaAA4+uBgjIGgKm6VbJSEP1KNc
         me03BTWNAm01WMUM6Gk6NRQfFyJr6Xt9Y6Uql8dsjunAQBFXlChEMPhBgLNJj1ljf90s
         0CSc6j3vTag1umNAYwX/J3WbLbyPDqqbZ64xGgNXkvuK0VCoTJi5PEBfgTCAKG0h+XL4
         HKcA==
X-Gm-Message-State: APjAAAXyyoyzbqsAE0w2/b963NWJPqeKLkCNwQa9675yPV2CHYw1uOy8
        aLc1JmPVg1SWXyqtJT5FV+g=
X-Google-Smtp-Source: APXvYqwJR7dMPEjyp+qS0dxF1UrR4Et4Bkh7AOZPNYbnvIUdRrbjey019pGcgmhs1gx6qDYJhMtjKw==
X-Received: by 2002:a63:5811:: with SMTP id m17mr30511053pgb.237.1565620364440;
        Mon, 12 Aug 2019 07:32:44 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k8sm99552727pgm.14.2019.08.12.07.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:32:43 -0700 (PDT)
Subject: Re: [PATCH RFC memory-model 27/31] tools/memory-model: Add data-race
 capabilities to judgelitmus.sh
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20190801222026.GA11315@linux.ibm.com>
 <20190801222056.12144-27-paulmck@linux.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
Date:   Mon, 12 Aug 2019 23:32:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801222056.12144-27-paulmck@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,
(CC: using Andrea's gmail address, adding Daniel)

Sorry for slow response, but please find inline comments below.

On Thu, 1 Aug 2019 15:20:52 -0700, Paul E. McKenney wrote:
> This commit adds functionality to judgelitmus.sh to allow it to handle
> both the "DATARACE" markers in the "Result:" comments in litmus tests
> and the "Flag data-race" markers in LKMM output.  For C-language tests,
> if either marker is present, the other must also be as well, at least for
> litmus tests having a "Result:" comment.  If the LKMM output indicates
> a data race, then failures of the Always/Sometimes/Never portion of the
> "Result:" prediction are forgiven.

I'd like to see the reason _why_ they can be forgiven. Also, updating
the header comment of judgelitimus.sh to mention these expansions would
be of much help.

My guess is any data-race would moot the Always/Sometimes/Never
prediction.

This reminds me that update of LKMM documentation regarding plain
accesses (data races) is yet to come.

        Thanks, Akira

> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
> index ca9a19829d79..eaa2cc7d3b36 100755
> --- a/tools/memory-model/scripts/judgelitmus.sh
> +++ b/tools/memory-model/scripts/judgelitmus.sh
> @@ -47,9 +47,27 @@ else
>  	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
>  	exit 255
>  fi
> +if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
> +then
> +	datarace_modeled=1
> +fi
>  if grep -q '^ \* Result: ' $litmus
>  then
>  	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
> +	if grep -m1 '^ \* Result: .* DATARACE' $litmus
> +	then
> +		datarace_predicted=1
> +	fi
> +	if test -n "$datarace_predicted" -a -z "$datarace_modeled" -a -z "$LKMM_HW_MAP_FILE"
> +	then
> +		echo '!!! Predicted data race not modeled' $litmus
> +		exit 252
> +	elif test -z "$datarace_predicted" -a -n "$datarace_modeled"
> +	then
> +		# Note that hardware models currently don't model data races
> +		echo '!!! Unexpected data race modeled' $litmus
> +		exit 253
> +	fi
>  elif test -n "$LKMM_HW_MAP_FILE" && grep -q '^Observation' $LKMM_DESTDIR/$lkmmout > /dev/null 2>&1
>  then
>  	outcome=`grep -m 1 '^Observation ' $LKMM_DESTDIR/$lkmmout | awk '{ print $3 }'`
> @@ -114,7 +132,7 @@ elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$o
>  then
>  	ret=0
>  else
> -	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
> +	if test \( -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes \) -o -n "$datarace_modeled"
>  	then
>  		flag="--- Forgiven"
>  		ret=0
> 

