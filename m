Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06478118D7B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJQYc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 11:24:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:42576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbfLJQYc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 11:24:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B3C9AC2F;
        Tue, 10 Dec 2019 16:24:30 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Felix Schnizlein <fschnizlein@suse.com>,
        linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Date:   Tue, 10 Dec 2019 17:24:29 +0100
Message-ID: <2363489.ZvMXcgbkLu@skinner.arch.suse.de>
In-Reply-To: <20191210144737.GB3975980@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de> <11195456.EmMzWPVPDU@skinner.arch.suse.de> <20191210144737.GB3975980@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday, December 10, 2019 3:47:37 PM CET Greg KH wrote:
> On Tue, Dec 10, 2019 at 02:33:07PM +0100, Thomas Renninger wrote:
> > On Monday, December 9, 2019 6:38:05 PM CET Will Deacon wrote:
> > > On Mon, Dec 09, 2019 at 12:28:44PM +0100, Thomas Renninger wrote:
> > > > On Monday, December 9, 2019 11:31:11 AM CET Will Deacon wrote:
> > > > > On Fri, Dec 06, 2019 at 05:24:21PM +0100, Thomas Renninger wrote:
> > > > > > From: Felix Schnizlein <fschnizlein@suse.de>
> > > > > > 
> > > > > > Export all information from /proc/cpuinfo to sysfs:
> > > > > > implementer, architecture, variant, part, revision,
> > > > > > bogomips and flags are exported.
> > > > > > 
> > > > > > Example:
> > > > > > /sys/devices/system/cpu/cpu1/info/:[0]# head *
> > > > 
> > > > ...
> > > > 
> > > > > > ==> flags <==
> > > > > > fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
> > > > 
> > > > ...
> > > > 
> > > > > I don't understand why we need this on arm64
> > 
> > Again: proc is moving to sys.
> 
> No.  New stuff is to be added to /sys/, don't add new things to /proc
> unless it deals with processes.
> 
> There is no mass-migration of existing /proc files to sysfs for no good
> reason.
> 
> > You probably export feature flags in /proc/cpuinfo for a good reason.
> > So where in sysfs should this show up?
> 
> Why does it have to live in sysfs if it is already in /proc and parsed
> properly by tools?

Parsing /proc/cpuinfo is the best example why we have sysfs...
Most important things have already been ported:

microcode       : 0x10
cat /sys/devices/system/cpu/cpu1/microcode/version
0x10

physical id     : 0
siblings        : 8
core id         : 1
cpu cores       : 4
...
/sys/devices/system/cpu/cpu1/topology/

clflush size    : 64
cache_alignment : 64
...
/sys/devices/system/cpu/cpu1/cache/


Only missing important info which still is needed is family/model/stepping, 
name, bugs and flags
cpufreq also got ported to sysfs quite some time ago already.

I am aware that /proc/cpuinfo won't vanish...
...the next decade. Still I am confident I will still see this.

Still relevant info which is accessed by (newly written) userspace tools 
should read out info via sysfs.

Beside microcode, topology, cache, cpufreq,...
info, there now is also family, model, stepping, bugs, flags and name

There rest is (from my perspective) really old ugly stuff and not needed 
anymore by recent tools.


   Thomas


