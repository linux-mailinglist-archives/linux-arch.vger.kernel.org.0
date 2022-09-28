Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365E5EDE3B
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 15:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiI1Ny0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1NyX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 09:54:23 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A339597D55;
        Wed, 28 Sep 2022 06:54:21 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id m4so5582774wrr.5;
        Wed, 28 Sep 2022 06:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7U1I9hHO4CrRfjBWf9qPspGBAU/gGgUqLwer2phGAFU=;
        b=lR+4ly1GqQ9V1Zw88E2NKqMKq6QGORarPQZ5OHb23RZqbxmo50m9MfeDRsb7Tzjz3k
         nDhKhmcV7SFAkvOdhJy6ZeQplE6iOBhMa4jZZTc16i5sN//nVdaqpUJ4doU8d3Y0de9H
         Uao+Qt3E4OKfYBDzJMve+ngOZjKaS4npyjLRGAiQEQQkeX/4DX3TSM2GqESvqCSlqHxo
         rJBLc9w69B5Ku1Ds4c60CqmjYjLgvcoGtNMpSlxnFJ8PPc4a1HPvjtMxux3r2HZOaLnK
         h93tlEB3TUqpQnwQ3HJYBU4m6T8gx8hjToQxUmMaqtADLb4/oyvvo+UQNLHdnkvvpdt/
         pWsQ==
X-Gm-Message-State: ACrzQf0PkmIQ8Xy21Q2cSv+FU48GBydD6vrlpZ/CYJef76VvZ+u6WEXc
        tsoHdz1fag02978M0hiZW1cMHTNQqGg=
X-Google-Smtp-Source: AMsMyM5vbRTCz4kNFJlsK857jirYeR1NUoxujP2E4vLye+cr6djGWanJ30AQBJBXmEUGSrIzv6vgpQ==
X-Received: by 2002:a05:6000:1849:b0:228:c87d:2578 with SMTP id c9-20020a056000184900b00228c87d2578mr20938938wri.274.1664373259492;
        Wed, 28 Sep 2022 06:54:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n16-20020adffe10000000b0022b014fb0b7sm4191199wrr.110.2022.09.28.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:54:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:54:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v6] hyperv: simplify and rename generate_guest_id
Message-ID: <YzRSCSOIhHQ9JYmr@liuwe-devbox-debian-v2>
References: <20220928064046.3545-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220928064046.3545-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 28, 2022 at 02:40:46PM +0800, Li kunyu wrote:
> The generate_guest_id function is more suitable for use after the
> following modifications.
> 1. The return value of the function is modified to u64.
> 2. Remove the d_info1 and d_info2 parameters from the function, keep the
> u64 type kernel_version parameter.
> 3. Rename the function to make it clearly a Hyper-V related function,
> and modify it to hv_generate_guest_id.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> 
> --------
>  v2: Fix generate_guest_id to hv_generate_guest_id.
>  v3: Fix [PATCH v2] asm-generic: Remove the ... to [PATCH v3] hyperv: simp
>      lify ... and remove extra spaces
>  v4: Remove #include <linux/version.h> in the calling file, and add #inclu
>      de <linux/version.h> in the function implementation file
>  v5: <linux/version.h> is changed to the definition position before v4, an
>      d the LINUX_VERSION_CODE macro is passed in the function call
>  v6: Modify the patch description information to the changed information a
>      fter discussion

This part -- normally the change history should be stripped when the
patch is committed with git-am(1).

The usual way of doing it is to place them (and any other text that is
not intended to be committed) after three dashes. No fewer, no more,
only three dashes.

Why three dashes? Git-am(1) has the following:

  The patch is expected to be inline, directly following the message. Any line that is of the
  form:

  •   three-dashes and end-of-line, or

  •   a line that begins with "diff -", or

  •   a line that begins with "Index: "

  is taken as the beginning of a patch, and the commit log message is terminated before the
  first occurrence of such a line.

Notice the last sentence. You used eight dashes. Git-am(1) does not
consider that pattern terminates the commit log message.

There is no need for you to do anything. I've cleaned up the commit
message and applied it to hyperv-next. I thought the above tidbit can
help you (or anyone else who doesn't know about this and happens to read
this lengthy email) in your future patch submission though. :-)

Thanks,
Wei.
