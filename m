Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7B7AFEAC
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 10:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjI0IfF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 04:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjI0Iei (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 04:34:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458F11B3;
        Wed, 27 Sep 2023 01:33:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E5CC433C7;
        Wed, 27 Sep 2023 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695803633;
        bh=I5DZTuEJvTywxXc0qMvlpl6ebHjK8ISFhOGKsz7oZgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=132Uw3jfwPEJVezfW+Ns78q1UcSiSTw9uJW4qYSDHVitzTUG01Mju4TknFo/4xRAd
         /3ztEnzyxLxFZ6/Zuozy30RmREj5YmdU7GxGWv70kzUN8BOtFkhYBDbUgS8n/FuajJ
         MTS49kXLOMUoQQ+edrzW2VHszhz2/Z9c8ZKwFnao=
Date:   Wed, 27 Sep 2023 10:33:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023092757-cupbearer-cancel-b314@gregkh>
References: <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
 <2023092630-masculine-clinic-19b6@gregkh>
 <ZRJyGrm4ufNZvN04@liuwe-devbox-debian-v2>
 <2023092614-tummy-dwelling-7063@gregkh>
 <ZRKBo5Nbw+exPkAj@liuwe-devbox-debian-v2>
 <2023092646-version-series-a7b5@gregkh>
 <05119cbc-155d-47c5-ab21-e6a08eba5dc4@linux.microsoft.com>
 <2023092737-daily-humility-f01c@gregkh>
 <ZRPiGk9M3aQr99Y5@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRPiGk9M3aQr99Y5@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 27, 2023 at 08:04:42AM +0000, Wei Liu wrote:
> On Wed, Sep 27, 2023 at 08:01:01AM +0200, Greg KH wrote:
> [...]
> > > > > If we're working with real devices like network cards or graphics cards
> > > > > I would agree -- it is easy to imagine that we have several cards of the
> > > > > same model in the system -- but in real world there won't be two
> > > > > hypervisor instances running on the same hardware.
> > > > > 
> > > > > We can stash the struct device inside some private data fields, but that
> > > > > doesn't change the fact that we're still having one instance of the
> > > > > structure. Is this what you want? Or do you have something else in mind?
> > > > 
> > > > You have a real device, it's how userspace interacts with your
> > > > subsystem.  Please use that, it is dynamically created and handled and
> > > > is the correct representation here.
> > > > 
> > > 
> > > Are you referring to the struct device we get from calling
> > > misc_register?
> > 
> > Yes.
> > 
> 
> We know about this, please see below. And we plan to use this.
> 
> > > How would you suggest we get a reference to that device via e.g. open()
> > > or ioctl() without keeping a global reference to it?
> > 
> > You explicitly have it in your open() and ioctl() call, you never need a
> > global reference for it the kernel gives it to you!
> > 
> 
> This is what I don't follow.
> 
> Nuno and I discussed this today offline. We looked at the code before
> and looked again today (well, yesterday now).
> 
> Here are the two functions:
> 
>     int vfs_open(const struct path *path, struct file *file)
>     long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> 
> Or, if we provide an open function in our file_operations struct, we get
> an additional struct inode pointer.
> 
>     int (*open) (struct inode *, struct file *);
> 
> Neither struct file nor struct inode contains a reference to struct device.
> 
> Then in vfs.rst, there is a section about open:
> 
> ``open``
>         called by the VFS when an inode should be opened.  When the VFS
>         opens a file, it creates a new "struct file".  It then calls the
>         open method for the newly allocated file structure.  You might
>         think that the open method really belongs in "struct
>         inode_operations", and you may be right.  I think it's done the
>         way it is because it makes filesystems simpler to implement.
>         The open() method is a good place to initialize the
>         "private_data" member in the file structure if you want to point
>         to a device structure
> 
> So, the driver is supposed to stash a pointer to struct device in
> private_data. That's what I alluded to in my previous reply. The core
> driver framework or the VFS doesn't give us a reference to struct
> device. We have to do it ourselves.

Please read Linux Device Drivers, 3rd edition, chapter 3, for how to do
this properly.  The book is free online.

Also look at the zillion in-kernel example drivers that use the misc
device api, container_of() is your friend...

> We can do that for sure, but the struct device we stash into
> private_data is going to be the one that is returned from misc_register,
> which at the same time is already stashed inside a static variable in
> our driver by our own code (Note that this is a pervasive pattern in the
> kernel).

Again, don't make this static, there's no requirement to do so.

But even if you do, sure, use it this way, you have a device.  But I
would strongly discourage you from having a static variable, there is no
need to do this at all, and no one else should do so either.

thanks,

greg k-h
