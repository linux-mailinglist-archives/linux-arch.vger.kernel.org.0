Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D446C3446
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjCUOdH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCUOdG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 10:33:06 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928228E87
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 07:33:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c18so18050636qte.5
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679409184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PE0Q2urSrQgTvUZSFNMrQiYswRteUmKjVjKK7YyvjOs=;
        b=pS1b6B4vl3/brpituXp0/WjTu4YeJGOtWmjmcBMPwY0q1e5UURFy0dHxKB2x6scs33
         f7DZjyOjGFO4+xLcU/TWBMw8DgUSp3E+PSI8V4sm0UJgXlIkrtn8aJR60PiuSo8s1PeI
         lRWYRjw4JD3xGeDnuKmpl/Cu/o2dIBQvvfZzl1M/j6jTVdyrYP0if6ou0Twdt2CpEvvK
         Xo20K1JEGf88s6ynPckpcIL/FAbdgIo239hBDnVXOqebJ+uT2W60hkdTDPzf+NX6jDUK
         2jxuok02LCb6kHGQ59iukpmOtG+9obX6tikY93CyL0AiQtaIstGdS5F4PiQ/e2nIRnC4
         UcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE0Q2urSrQgTvUZSFNMrQiYswRteUmKjVjKK7YyvjOs=;
        b=2kPy8Hv6gSDFUbTckz8T79pJ5AUc2XPmlB9l1r95lCTTjUeF53SOm60P6nsVulOEv9
         aSABTKnINN0PhOZDl6LQMr3LErQEdFvnRevapENQct1wW41u7zwOtlCehSvBoDSgIidQ
         l3nlhwkYco3NVH7Bd/ONse4+29/vbCQulx9Uu/70V9wpD1jeyMfihE/S6G1zIYFG9ZFq
         HRgdgmrnnK9qs7DlQwZPT8daOlrUCA/q4bmztiYjzgY/cow2tKwv+2gKRaQKhLpQmTHs
         fyc8sW8UlXk5OwMTmBBbNNfj8N41MTAn1x8cJyHzEVC2gotN6qX9Qeqa/mH4vh0REcH6
         zqcg==
X-Gm-Message-State: AO0yUKXLazK3ctAx/nh6066iLogqKSmaMAzx2NE9GDU5QqcZLyMmoD9/
        LMlqeH5APNHt2wc78FTyTfkjDw==
X-Google-Smtp-Source: AK7set9R/JiYTa+wywUxBgEMSGSbgZkcQlBT/C6J1sAycNW5wTVKmIe6cUHx5pgx1Hsf4sp+7n0u1A==
X-Received: by 2002:a05:622a:20e:b0:3bf:d7f8:4f85 with SMTP id b14-20020a05622a020e00b003bfd7f84f85mr161977qtx.12.1679409183856;
        Tue, 21 Mar 2023 07:33:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id i18-20020ac84f52000000b003d621964626sm8484287qtw.8.2023.03.21.07.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:33:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ped2s-000VQL-PI;
        Tue, 21 Mar 2023 11:33:02 -0300
Date:   Tue, 21 Mar 2023 11:33:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 03/38] char: impi, tpm: depend on HAS_IOPORT
Message-ID: <ZBnAHoPy4SiaD1Xu@ziepe.ca>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-4-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314121216.413434-4-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023 at 01:11:41PM +0100, Niklas Schnelle wrote:
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 9c924a1440a9..2d2ae37153ba 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -51,34 +51,40 @@ static struct tpm_inf_dev tpm_dev;
>  
>  static inline void tpm_data_out(unsigned char data, unsigned char offset)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype == TPM_INF_IO_PORT)
>  		outb(data, tpm_dev.data_regs + offset);

You should ifdef away TPM_INF_IO_PORT as well

Jason
