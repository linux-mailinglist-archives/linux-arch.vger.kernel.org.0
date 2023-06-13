Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A372E719
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbjFMPYF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242691AbjFMPYE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 11:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7439F1BFA;
        Tue, 13 Jun 2023 08:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E825E6310C;
        Tue, 13 Jun 2023 15:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3159FC433D9;
        Tue, 13 Jun 2023 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686669836;
        bh=gI5doYgRfMofGjT9jMpVOJtgqohz3PZgcnpMR4llu+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPxmmgUqli1kP36bGmtE6gZoZAWerjpUbzttilc5kOgIyRHokjRh21DhunuSie3FI
         hB7QbSQKLh2poN66lGx2zuNEIyxsHmviaeT/IbaZjkC22UnGPalLkUMkig/o3VMrg6
         F0QjTsUloh9tc/6q9NoPd14Tmt8fMyPdhrbkTFvt9XSRGtXxJd6em6FauYfnfMKoJX
         hSWvXZA3r78P4NYGuRjxN/3J+AjDEJy/7dyNfnrGVQgCjfewgDaQBNS6p76+26duG1
         pn925yJSOHquA7IkniKjr0HYbypH78IyPbIGelPjChmr371teAN5aSY9b9EvBfBVqT
         9nZAVxrtLp01w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB37540692; Tue, 13 Jun 2023 12:23:53 -0300 (-03)
Date:   Tue, 13 Jun 2023 12:23:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 5/5] perf arm-spe: Fix a dangling Documentation/arm64
 reference
Message-ID: <ZIiKCQVWunpV2Bo1@kernel.org>
References: <20230613094606.334687-1-corbet@lwn.net>
 <20230613094606.334687-6-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613094606.334687-6-corbet@lwn.net>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Tue, Jun 13, 2023 at 03:46:06AM -0600, Jonathan Corbet escreveu:
> The arm64 documentation has moved under Documentation/arch/.  Fix up a
> dangling reference to match.

Its not upstream nor in the perf-tools-next, so please merge it in the
tree where this documentation move took place.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index f3918f290df5..ba807071d3c1 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -51,7 +51,7 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
>  		 * (bits [63:56]) is assigned as top-byte tag; so we only can
>  		 * retrieve address value from bits [55:0].
>  		 *
> -		 * According to Documentation/arm64/memory.rst, if detects the
> +		 * According to Documentation/arch/arm64/memory.rst, if detects the
>  		 * specific pattern in bits [55:52] of payload which falls in
>  		 * the kernel space, should fixup the top byte and this allows
>  		 * perf tool to parse DSO symbol for data address correctly.
> -- 
> 2.40.1
> 

-- 

- Arnaldo
