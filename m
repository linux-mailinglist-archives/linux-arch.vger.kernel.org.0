Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AEF51595B
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 02:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiD3AlP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 20:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiD3AlO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 20:41:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2305222B2;
        Fri, 29 Apr 2022 17:37:53 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q8so9750636oif.13;
        Fri, 29 Apr 2022 17:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SsTYFsW9i1zHPnNrYw8lfj7SDD5us1gW4k/mcBilZjs=;
        b=NJDFUY0Mj5T1UVU3nWD9kknn52XSQL1mQkufyWb7q7fF3FrwaJbN5nEyLyy8X/Sko8
         hKFUC+VCOU1hOlRm8oSVbK6+CP9xRBn2v4wrzHOv3qyOtsCxOAtYydnhKANE9mtPjVNs
         0NYV4nEiEia/1g1n52UNVi32zvWZZ+xwUPV9yuHgRRlo/nrwT1QbzmS+JCzwAS1rKcXJ
         J4w5/eeZiyJdjeu71Fqum9U7hgsVL6EeyGiUA8a67Ls7CsndpllF7gRnWfomee53cOIk
         VfYJwl4zlCFB8PDTcRbXjQDa70UXlPWj2qCPftxccLb7Xt/WSRKkVqSyZp2ekHIK/wIm
         eiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SsTYFsW9i1zHPnNrYw8lfj7SDD5us1gW4k/mcBilZjs=;
        b=Q7Nq4/XRXidZAcDcHxD0HiDriBRttZLH17aClQ4xkNd52X22BY/FXCumOQcQ0BpjM2
         vHNZVZxcvcEHoXXUmAGL+Lt6LbpWgQS1/t0TzAHr8vSsr2VNNk5v8v/ifuc3n40G9IDV
         s6KYGBx5Y4xdPNo8N3zN9CMoC7ta5QkrM3rHOEohAX2Iz0VjdB7KDyF2BsWV7ONsNGm2
         JE1C0lCqTMZDWSnwTgd99AzeOYpSwSLHZ2XsrNTBICIPEjAauyqE0gGAGGzrCS4Vol4f
         PHNoFA0KhRoS/ncXU/bTRkVcUZuz0NMcjWn3cM+zrYrJjlBJfMygXeL/yccHgJV54Gwq
         eUyw==
X-Gm-Message-State: AOAM5301BPZqDnlZc1UhLWrN4GQkEpW5VzVkiacaMQMvLSsRp08HVYEb
        yitDDwy+eZyOG1i+G1Lm3KU=
X-Google-Smtp-Source: ABdhPJxgeBPy5mQFpWx/O7B53dhbN0ypl4LfJ4Fw9t0SQxmhLJedMbi72uZgmMjdIZd+YPv/Dga3Pg==
X-Received: by 2002:a05:6808:3a8:b0:325:b138:bd62 with SMTP id n8-20020a05680803a800b00325b138bd62mr2545223oie.270.1651279073366;
        Fri, 29 Apr 2022 17:37:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8-20020a056870124800b000e686d13888sm3810854oao.34.2022.04.29.17.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 17:37:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 29 Apr 2022 17:37:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [RFC v2 11/39] hwmon: add HAS_IOPORT dependencies
Message-ID: <20220430003751.GA2446353@roeck-us.net>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-20-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-20-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:50:17PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

... assuming that the plan is to push those together. If not let me know.

Guenter
