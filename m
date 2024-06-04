Return-Path: <linux-arch+bounces-4658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB068FA983
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C961F24029
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF2C13D516;
	Tue,  4 Jun 2024 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpkzF69L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA22A8D0;
	Tue,  4 Jun 2024 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477839; cv=none; b=n6jJovWHguMmUlfbd+GcmnthR538nifurzhe8+kkhs98uTq4TixJV8heySyW+cYoCH3gS9+uNLuuukbJ70UozfirnnXFuRV8g33ImrHJH2Kt+XZ6SAryfzTeIQVPkyhMvUmQPtrWA3x+cVg2mqm96B4eH75CBrPjPoO2UeRBa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477839; c=relaxed/simple;
	bh=cXg9Uh+mwdg7QtODtpq80TFwDa4ZVOdly16SztyY8+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=euaHWL72Hh+Hr/Z2btTu5CTpJgtx6WRk/1k2T0x+mlLIDL6kJuSAgfuAYzsASLldEKZCrqUNUiO0/Toyj+mV3LC2wS/NzaHGz7s2LpqcJmGIuJFm7JNBX4qn4XJbmrcuLALEz8Or3OP1C+IRtDoM4cTfYoVl9U8P19XdlLYfEC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpkzF69L; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f8d2ec8652so3067792a34.3;
        Mon, 03 Jun 2024 22:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477836; x=1718082636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lR9xxF67xkv8Jh6JeaRQRfZn3f3Gas3sg1WacLeR+Fw=;
        b=KpkzF69L5rg6zs6U2SVIyJIyyDUucKXFC0pioDpHf9onZmemJFDWwcM64vNqcF2ulM
         mx/66etouP5ttqbGpt0TDb90xKNHG9V8Y5Fjhav7OaLXrjbAiseAXvF+ddNO0KtSs+Gp
         /iq5B+fEdZUr2cFL0n7f62owAH0QfuiM1wPpXylv9oSWDsVOz5XaLHSDKSTbPphwUevb
         7hfOF7HUZenwir/3nkxXBgH5EA7Hu6zKqQaZ7UIUronKyIigMkJm+sNUVxtt2seuzNQR
         4kbPy2Izwf6mW9iPadJEwXREgo4i2yFxWi8rez/COFyjKcvDCJqd9+hDDq1hGpmb0oBN
         JubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477836; x=1718082636;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR9xxF67xkv8Jh6JeaRQRfZn3f3Gas3sg1WacLeR+Fw=;
        b=hy32HnTc8imqJC8Bu5P7fbr9Vc0YNzNfu/mW9Y12fWpkokd44Nk0W6tZZ7fNDBZw9p
         6PbFUFXVoCWA/VFtVsEyfRQUYQKxSs6lI50b6vscrt7G8bJZbN9gTp+xXmaMsuf92id0
         JrVUv6o25ITUrPZL4R/zdQMCVUbyMj1HV5dlZ92UrpxDiavClxF3LCdvZgwQCI+9Ub8i
         d5gLdQHpgEsBXkEmQecppVEp2OOftKQQIxq730yBREvRDiYNDQchBaXFNM8E5+YdAvka
         S4XJ/nuMevY3wCJziIEM/jweKN2nUC9qMD0E/N9UU6bLiVg6zmKlZj+Y7Y2mGOOls6dU
         xfig==
X-Forwarded-Encrypted: i=1; AJvYcCXAxSjQysLLNM+Ib77QqmOxpFeKeUs5/4LXz+h9PMy9rOiPgMx6LDDASkJ50O3J7ZPpFUOQyPjAXjc9OwYIDNnel/iqLHXhCJ4V7mT67I6HgoU/91Btt+U8uohB3svk6cdc7M7y5Yj6YVbqeLy2W+Q6ezb7W0c1qFQw8bMQd61I8AuixOJfPYnRp/6SDbt3NAAKON56VtTgJGoDBgWKvQdCEnI4PSwUjohuuRoa9PNcEuni0sGS1etDR7TXzfc=
X-Gm-Message-State: AOJu0YxF6tJZkNH9nDASAXak8XSc6WlRrCJbSiSm4s0PTwic28+QOCwa
	jqQlA6UZJWxyzUCBAbItp9yd9ZgrHvFRPzVU0haYcMubaq7wPsmX
X-Google-Smtp-Source: AGHT+IEya7cZOohNIqUZ/PLElWCaPIt+W1R3BZWdLXmWEbtERH6DJ1vLUCCh+IvPi3IGCg/P506MIA==
X-Received: by 2002:a05:6870:718b:b0:24f:c0bc:5ac6 with SMTP id 586e51a60fabf-2508b9b3b00mr12243100fac.11.1717477836142;
        Mon, 03 Jun 2024 22:10:36 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:35 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	arnd@arndb.de,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: maz@kernel.org,
	den@valinux.co.jp,
	jgowans@amazon.com,
	dawei.li@shingroup.cn
Subject: [RFC 00/12] Hyper-V guests use Linux IRQs for channel interrupts
Date: Mon,  3 Jun 2024 22:09:28 -0700
Message-Id: <20240604050940.859909-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

This patch set makes significant changes in how Linux guests running on Hyper-V
handle interrupts from VMBus devices. It's "RFC" because of the level of change,
and because I'm interested in macro-level feedback on the whole idea. The usual
detailed-level code review feedback is also welcome.

Background
----------
Linux guests running on Hyper-V are presented with a range of synthetic
devices, including storage, networking, mouse, keyboard, etc. Guests are also
presented with management-related pseudo-devices, including time
synchronization, heartbeat, and host-initiated shutdown. These devices use the
VMBus connection between the host and the guest, and each device has one or
more VMBus channels for passing messages between the host and guest.
Separately, a control path exists for creating and tearing down VMBus channels
when needed. Hyper-V VMBus and its synthetic devices play a role similar to
virtio and virtio devices.

The host interrupts the guest when it sends a new message to the guest in an
otherwise empty channel, and when it sends a new control message to the guest.
All interrupts are multiplexed onto a single per-CPU architectural interrupt as
defined by the processor architecture. On arm64, this architectural interrupt
is a PPI, and is represented in Linux as a Linux per-CPU IRQ. The x86/x64
architecture does not provide per-CPU interrupts, so Linux reserves a fixed x86
interrupt vector (HYPERVISOR_CALLBACK_VECTOR) on all CPUs, with a hard-coded
interrupt handler. No Linux IRQ is assigned on x86/x64.

The interrupt handler for the architectural interrupt is the VMBus interrupt
handler, and it runs whenever the host generates an interrupt for a channel or
a control message. The VMBus interrupt handler consults data structures
provided by the per-CPU Hyper-V synthetic interrupt controller (synic) to
determine which channel or channels have a pending interrupt, or if there is a
pending control message. When doing this demultiplexing, the VMBus interrupt
handler directly invokes the per-device handlers, and processes any control
messages.

In this scheme, the individual VMBus devices and their channels are not
modelled as Linux IRQs. /proc/interrupts shows counts for the top-level
architectural interrupt, but not for the individual VMBus devices. The VMBus
driver has implemented separate reporting of per-device data under /sys.
Similarly, /proc/irq/<nn> does not show affinity information for individual
VMBus devices, and the affinity cannot be changed via /proc/irq. Again, a
separate interface under /sys is provided for changing the vCPU that a VMBus
channel should interrupt.

What's New
----------
Linux kernel community members have commented that it would be better for the
Hyper-V synic and the handling of VMBus channel interrupts to be modelled as
Linux IRQs. Then they would participate in existing IRQ handling mechanisms,
and not need something separate under /sys. This patch set provides such an
implementation.

With this patch set, the output of /proc/interrupts looks like this in a Linux
guest on a Hyper-V x86/x64 Generation 2 VM with 8 vCPUs (the columns for
CPUs 2 thru 5 are omitted due to text width considerations):

           CPU0       CPU1        CPU6       CPU7
  8:          0          0           0          0   IO-APIC   8-edge      rtc0
  9:          2          0           0          0   IO-APIC   9-fasteoi   acpi
 24:      16841          0           0          0     VMBus   7  heartbeat
 25:          1          0           0          0     VMBus   9  shutdown
 26:       6752          0           0          0     VMBus  10  timesync
 27:          1          0           0          0     VMBus  11  vss
 28:      22095          0           0          0     VMBus  14  pri@storvsc1
 29:          0         85           0          0     VMBus  15  pri@storvsc0
 30:          3          0           0          0     VMBus   1  balloon
 31:        106          0           0          0     VMBus   3  mouse
 32:         73          0           0          0     VMBus   4  keyboard
 33:          6          0           0          0     VMBus   5  framebuffer
 34:          0          0           0          0     VMBus  13  netvsc
 35:          1          0           0          0     VMBus   8  kvp
 36:          0          0           0          0     VMBus  16  netvsc
 37:          0          0           0          0     VMBus  17  netvsc
 38:          0          0           0          0     VMBus  18  netvsc
 39:          0          0        2375          0     VMBus  19  netvsc
 40:          0          0           0       1178     VMBus  20  netvsc
 41:       1003          0           0          0     VMBus  21  netvsc
 42:          0       4337           0          0     VMBus  22  netvsc
 43:          0          0           0          0     VMBus  23  sub@storvsc1
 44:          0          0           0          0     VMBus  24  sub@storvsc0
NMI:          0          0           0          0   Non-maskable interrupts
LOC:          0          0           0          0   Local timer interrupts
SPU:          0          0           0          0   Spurious interrupts
PMI:          0          0           0          0   Performance monitoring interrupts
IWI:          1          0           0          2   IRQ work interrupts
RTR:          0          0           0          0   APIC ICR read retries
RES:        411        233         349        318   Rescheduling interrupts
CAL:     135236      29211       99526      36424   Function call interrupts
TLB:          0          0           0          0   TLB shootdowns
TRM:          0          0           0          0   Thermal event interrupts
THR:          0          0           0          0   Threshold APIC interrupts
DFR:          0          0           0          0   Deferred Error APIC interrupts
MCE:          0          0           0          0   Machine check exceptions
MCP:        109        109         109        109   Machine check polls
HYP:         71          0           0          0   Hypervisor callback interrupts
HRE:          0          0           0          0   Hyper-V reenlightenment interrupts
HVS:     183391     109695      181539     339239   Hyper-V stimer0 interrupts
ERR:          0
MIS:          0
PIN:          0          0           0          0   Posted-interrupt notification event
NPI:          0          0           0          0   Nested posted-interrupt event
PIW:          0          0           0          0   Posted-interrupt wakeup event

IRQs 24 thru 44 are the VMBus channel IRQs that didn't previously exist. Some
devices, such as storvsc and netvsc, have multiple channels, each of which has
a separate IRQ. The HYP line now shows counts only for control messages instead
of for all VMBus interrupts. The HVS line continues to show Hyper-V synthetic
timer (stimer0) interrupts. (In older versions of Hyper-V where stimer0
interrupts are delivered as control messages, those interrupts are accounted
for on the HYP line. Since this is legacy behavior, it seemed unnecessary to
create a separate Linux IRQ to model these messages.)

The basic approach is to update the VMBus channel create/open/close/delete
infrastructure, and the VMBus interrupt handler, to create and process the
additional IRQs. The goal is that individual VMBus drivers require no code
changes to work with the new IRQs. However, a driver may optionally annotate
the IRQ using knowledge that only the driver has. For example, in the above
/proc/interrupts output, the storvsc driver for synthetic disks has been
updated to distinguish the primary channel from the subchannels, and to
distinguish controller 0 from controller 1. Since storvsc models a SCSI
controller, the numeric designations are set to match the "host0" and "host1"
SCSI controllers that could be seen with "lsscsi -H -v". Similarly annotating
the "netvsc" entries is a "to do" item.

In furtherance of the "no changes to existing VMBus drivers" goal, all VMBus
IRQs use the same interrupt handler. Each channel has a callback function
associated with it, and the interrupt handler invokes this callback in the same
way as before VMBus IRQs were introduced.

VMBus code creates a standalone linear IRQ domain for the VMBus IRQs. The hwirq
#'s are the VMBus channel relid's, which are integers in the range 1 to 2047.
Each relid uniquely identifies a VMBus channel, and a channel interrupt from
the host provides the relid. A mapping from IRQ to hwirq (relid) is created
when a new channel is created, and the mapping is deleted when the channel is
deleted, so adding and removing VMBus devices in a running VM is fully
functional.

Getting the IRQ counting correct requires a new IRQ flow handler in
/kernel/irq/chip.c. See Patch 6. The existing flow handlers don't handle this
case, and creating a custom flow handler outside of chip.c isn't feasible
because the needed components aren't available to code outside of /kernel/irq.

When a guest CPU is taken offline, Linux automatically changes the affinity of
IRQs assigned to that CPU so that the IRQ is handled on another CPU that is
still online. Unfortunately, VMBus channel IRQs are not able to take advantage
of that mechanism. At the point the mechanism runs, it isn't possible to know
when Hyper-V started interrupting the new CPU; hence pending interrupts may be
stranded on the old offline CPU. Existing VMBus code in Linux prevents a CPU
from going offline when a VMBus channel interrupt is affined to it, and that
code must be retained. Of course, VMBus channel IRQs can manually be affined to
a different CPU, which could then allow a CPU to be taken offline. I have an
idea for a somewhat convoluted way to allow the automatic Linux mechanism to
work, but that will be another patch set.

Having VMBus channel interrupts appear in /proc/irq means that user-space
irqbalance can change the affinity of the interrupts, where previously it could
not. For example, this gives irqbalance the ability to change (and perhaps
degrade) the default affinity configuration that was designed to maximize
network throughput. This is yet another reason to disable irqbalance in VM
images.

The custom VMBus entries under /sys are retained for backwards compatibility,
but they are integrated. For example, changing the affinity via /proc/irq is
reflected in /sys/bus/vmbus/devices/<guid>/channels/<nn>/cpu, and vice versa.

Patches
-------
The patches have been tested on x86/x64 Generation 1 and Generation 2 VMs, and
on arm64 VMs.

* Patches 1 and 2 fixes some error handling that is needed by subsequent
patches. They could be applied independent of this patch set.

* Patches 3,4, and 5 add support for IRQ names, and add annotations in the
storvsc and the Hyper-V vPCI driver so that descriptions in /proc/interrupts
convey useful information.

* Patch 6 adds a new IRQ flow handler needed to properly account for IRQs as
VMBus IRQs or as the top-level architectural interrupt.

* Patch 7 creates the new IRQ domain for VMBus channel IRQs.

* Patch 8 allocates the VMBus channel IRQs, and creates the mapping between
VMBus relid (used as the hwirq) and the Linux IRQ number. That mapping is then
used for lookups.

* Patch 9 does request_irq() for the new VMBus channel IRQs, and converts the
top-level VMBus architectural interrupt handler to use the new VMBus channel
IRQs for handling channel interrupts. With this patch, /proc/interrupts shows
counts for the VMBus channel IRQs.

* Patch 10 implements the irq_set_affinity() function for VMBus channel IRQs,
and integrates it with the existing Hyper-V-specific sysfs mechanism for
changing the CPU that a VMBus channel will interrupt.

* Patch 11 updates hv_synic_cleanup() during CPU offlining to handle the lack
of waiting for the MODIFYCHANNEL message in vmbus_irq_set_affinity() in Patch
10.

* Patch 12 fixes a race in VMBus channel interrupt assignments that existed
prior to this patch set when taking a CPU offline.

Open Topics
-----------
* The performance impact of the additional IRQ processing in the interrupt path
appears to be minimal, based on looking at the code. Measurements are still to
be taken to confirm this.

* Does the netvsc driver have sufficient information to annotate what appears
in /proc/interrupts, particularly when multiple synthetic NICs are present? At
first glance, it appears that the identifying info isn't generated until after
vmbus_open() is called, and by then it's too late to do the IRQ annotation.
Need some input from a netvsc expert.

* The VMBus irq domain and irq chip data structures are placed in the
vmbus_connection structure. Starting with VMBus protocol version 5.0, the VMBus
host side supports multiple connections from a single guest instance (see
commit ae20b254306a6). While there's no upstream kernel code that creates
multiple VMBus connections, it's unclear whether the IRQ domain should be
global across all VMBus connection, or per connection. Are relid's global (to
the VM) or per connection?

* I have not tried or tested any hv_sock channels. Is there a handy test
program that would be convenient for opening multiple hv_sock connections to
the guest, have them persist long enough to see what /proc/interrupts shows,
and try changing the IRQ affinity?

* I have not tried or tested Linux guest hibernation paths.

The patches build and run against 6.10-rc2 and next-20240603.

Michael Kelley (12):
  Drivers: hv: vmbus: Drop unsupported VMBus devices earlier
  Drivers: hv: vmbus: Fix error path that deletes non-existent sysfs
    group
  Drivers: hv: vmbus: Add an IRQ name to VMBus channels
  PCI: hv: Annotate the VMBus channel IRQ name
  scsi: storvsc: Annotate the VMBus channel IRQ name
  genirq: Add per-cpu flow handler with conditional IRQ stats
  Drivers: hv: vmbus: Set up irqdomain and irqchip for the VMBus
    connection
  Drivers: hv: vmbus: Allocate an IRQ per channel and use for relid
    mapping
  Drivers: hv: vmbus: Use Linux IRQs to handle VMBus channel interrupts
  Drivers: hv: vmbus: Implement vmbus_irq_set_affinity
  Drivers: hv: vmbus: Wait for MODIFYCHANNEL to finish when offlining
    CPUs
  Drivers: hv: vmbus: Ensure IRQ affinity isn't set to a CPU going
    offline

 arch/x86/kernel/cpu/mshyperv.c      |   9 +-
 drivers/hv/channel.c                | 125 ++++------
 drivers/hv/channel_mgmt.c           | 139 ++++++++----
 drivers/hv/connection.c             |  48 ++--
 drivers/hv/hv.c                     |  90 +++++++-
 drivers/hv/hv_common.c              |   2 +-
 drivers/hv/hyperv_vmbus.h           |  22 +-
 drivers/hv/vmbus_drv.c              | 338 +++++++++++++++++++---------
 drivers/pci/controller/pci-hyperv.c |   5 +
 drivers/scsi/storvsc_drv.c          |   9 +
 include/asm-generic/mshyperv.h      |   9 +-
 include/linux/hyperv.h              |   9 +
 include/linux/irq.h                 |   1 +
 kernel/irq/chip.c                   |  29 +++
 14 files changed, 567 insertions(+), 268 deletions(-)

-- 
2.25.1


