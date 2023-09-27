Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3D7AFD8D
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjI0IEu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 04:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjI0IEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 04:04:47 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03471192;
        Wed, 27 Sep 2023 01:04:45 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c453379020so77202055ad.1;
        Wed, 27 Sep 2023 01:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801885; x=1696406685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+9Ak0c2CWF0EmQbSLIn7TF/+0ZVwVc4k741kL8T3IE=;
        b=XkZZHruWMP1/LpTwXuMRzhxwzpRPFJ99JEdmxCSEnAx+aqzCHpMxw8oZvm7tHzQT9L
         VSjNE1AwUs1ffv7NUB7Uw//I/DLiMIaDrKVoYGaJFe6TTlWkVl2WyJBIYjzKNPNAcPFj
         a1KhCSFEk1rU7VsiyWO6DTV4vUeLfos+BoiZHtQYD5Ei3KEePtPCT+2/Zozf6oi8eysZ
         YvLKxnW8o2mx2YXTMmz/WSSYXBvWILU4aguqF06IqYD9FdpQc671q43lmMo1dOiyPOAS
         wGFqkyD1klyJq7azdAhhRqTqtKWbeizxcuxIIyfJQNZbJO1PQ1EdyTWL4z3TlZ1s1Rox
         DSqg==
X-Gm-Message-State: AOJu0Yztjon8zN+wmAJZQ8V2aAqYGMdy610Ut2qT/ZJOYGtnHKNezvsS
        qCDK637uA7YiWyL+5aHj6sA=
X-Google-Smtp-Source: AGHT+IHuo2vPTXHPtUr+Jdhbtq6mdhlDLNV8GOJEdj+eRvvJSqP8VRngCuIMAg2QN5gTkHP1/VwhjQ==
X-Received: by 2002:a17:902:ef96:b0:1c6:19da:b29d with SMTP id iz22-20020a170902ef9600b001c619dab29dmr948578plb.44.1695801885181;
        Wed, 27 Sep 2023 01:04:45 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709028d8a00b001c5fda4d3eesm8407167plo.261.2023.09.27.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:04:44 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:04:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <ZRPiGk9M3aQr99Y5@liuwe-devbox-debian-v2>
References: <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
 <2023092630-masculine-clinic-19b6@gregkh>
 <ZRJyGrm4ufNZvN04@liuwe-devbox-debian-v2>
 <2023092614-tummy-dwelling-7063@gregkh>
 <ZRKBo5Nbw+exPkAj@liuwe-devbox-debian-v2>
 <2023092646-version-series-a7b5@gregkh>
 <05119cbc-155d-47c5-ab21-e6a08eba5dc4@linux.microsoft.com>
 <2023092737-daily-humility-f01c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023092737-daily-humility-f01c@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Greg

It is past midnight here, so I may not be able to articulate my thoughts
very well. I want to avoid waiting for another day for another round
trip of emails though. We can look at your reply in the morning and
reply again.

On Wed, Sep 27, 2023 at 08:01:01AM +0200, Greg KH wrote:
[...]
> > > > If we're working with real devices like network cards or graphics cards
> > > > I would agree -- it is easy to imagine that we have several cards of the
> > > > same model in the system -- but in real world there won't be two
> > > > hypervisor instances running on the same hardware.
> > > > 
> > > > We can stash the struct device inside some private data fields, but that
> > > > doesn't change the fact that we're still having one instance of the
> > > > structure. Is this what you want? Or do you have something else in mind?
> > > 
> > > You have a real device, it's how userspace interacts with your
> > > subsystem.  Please use that, it is dynamically created and handled and
> > > is the correct representation here.
> > > 
> > 
> > Are you referring to the struct device we get from calling
> > misc_register?
> 
> Yes.
> 

We know about this, please see below. And we plan to use this.

> > How would you suggest we get a reference to that device via e.g. open()
> > or ioctl() without keeping a global reference to it?
> 
> You explicitly have it in your open() and ioctl() call, you never need a
> global reference for it the kernel gives it to you!
> 

This is what I don't follow.

Nuno and I discussed this today offline. We looked at the code before
and looked again today (well, yesterday now).

Here are the two functions:

    int vfs_open(const struct path *path, struct file *file)
    long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)

Or, if we provide an open function in our file_operations struct, we get
an additional struct inode pointer.

    int (*open) (struct inode *, struct file *);

Neither struct file nor struct inode contains a reference to struct device.

Then in vfs.rst, there is a section about open:

``open``
        called by the VFS when an inode should be opened.  When the VFS
        opens a file, it creates a new "struct file".  It then calls the
        open method for the newly allocated file structure.  You might
        think that the open method really belongs in "struct
        inode_operations", and you may be right.  I think it's done the
        way it is because it makes filesystems simpler to implement.
        The open() method is a good place to initialize the
        "private_data" member in the file structure if you want to point
        to a device structure

So, the driver is supposed to stash a pointer to struct device in
private_data. That's what I alluded to in my previous reply. The core
driver framework or the VFS doesn't give us a reference to struct
device. We have to do it ourselves.

We can do that for sure, but the struct device we stash into
private_data is going to be the one that is returned from misc_register,
which at the same time is already stashed inside a static variable in
our driver by our own code (Note that this is a pervasive pattern in the
kernel).

I hope this is clear. If we're missing something extremely obvious, that
somehow we can get a reference to struct device from the VFS while
opening the file or doing ioctl without stashing it ourselves in our own
code, please let us know.

At this point I feel like either I'm extremely stupid or we're just
talking past each other. If you tell me it is the former and help me
understand how we can achieve what you described, I am more than happy
to learn new things I don't know or understand. :-)

If we have to propagate that reference ourselves, that then leads to
next question whether it will just be more convenient to use the stashed
value in the static variable directly like other drivers do, instead of
stashing and propagating it around, knowing 100% it is the same object.
I don't feel too strongly about this. As long as we are on the same page
about getting a reference to struct device, we can do it either way.

Thanks,
Wei.


> thanks,
> 
> greg k-h
> 
