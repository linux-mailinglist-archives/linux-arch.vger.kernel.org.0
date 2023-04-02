Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA23C6D35D2
	for <lists+linux-arch@lfdr.de>; Sun,  2 Apr 2023 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjDBGo3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Apr 2023 02:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDBGo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Apr 2023 02:44:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165218F9D;
        Sat,  1 Apr 2023 23:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 607F6B80DE7;
        Sun,  2 Apr 2023 06:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC24C433EF;
        Sun,  2 Apr 2023 06:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680417863;
        bh=GUQg6sGb3Mll+C2A+4jtpUVp3KDL2ntbwa75b/ih8K0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=awl2CvdMu+RsKngdYbfXBeBxzG4atEKaPYz0ghwrS4zk0bUy6nfht4DfKqeX/a0BO
         YpJ1/NKNs2MeSe3DwiZ2FJXcCrngH+lLB+9IX8RbjSU4wHvSlVfl6hOD9FLYEltwqn
         62IMpax+Q/Lj3sWGpDEmyP9fM56HddM9coqR3t6cXjZrn4LlP9Vi3v4ny+5vFBKX70
         mdUQmPFYkuxjTc2b9WKdaqYnSX+AHZfwTzzbjBONKIDDIIcY93/cmNMCP07rsog8Te
         GLhAHUTo8ZsZSbaGKDMu31g8c44ChXmcP7LDG52zNxJT+2GscJigJQ9Yb1o9wuXn3G
         J0iMlZo6ZnY4A==
Message-ID: <fc16ca68-24ee-7cff-9693-2678cbbcd946@kernel.org>
Date:   Sun, 2 Apr 2023 12:14:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] docs: Move arc architecture docs under
 Documentation/arch/
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>
References: <20230330195604.269346-1-corbet@lwn.net>
 <20230330195604.269346-2-corbet@lwn.net>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20230330195604.269346-2-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 3/31/23 01:26, Jonathan Corbet wrote:
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/arc into arch/ and fix all in-tree references.
>
> Cc: Vineet Gupta<vgupta@kernel.org>
> Signed-off-by: Jonathan Corbet<corbet@lwn.net>

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx,
-Vineet
