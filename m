Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34042AD465
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 12:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgKJLFv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 06:05:51 -0500
Received: from foss.arm.com ([217.140.110.172]:53968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJLFv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 06:05:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72B0111D4;
        Tue, 10 Nov 2020 03:05:50 -0800 (PST)
Received: from [10.57.21.178] (unknown [10.57.21.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60C103F6CF;
        Tue, 10 Nov 2020 03:05:48 -0800 (PST)
Subject: Re: [PATCH 3/4] powercap/drivers/dtpm: Add API for dynamic thermal
 power management
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-4-daniel.lezcano@linaro.org>
 <8fea0109-30d4-7d67-ffeb-8e588a4dadc3@arm.com>
Message-ID: <313a92c5-3c45-616f-1fe8-9837721f9889@arm.com>
Date:   Tue, 10 Nov 2020 11:05:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8fea0109-30d4-7d67-ffeb-8e588a4dadc3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Actually I've found one issue when I have been trying to clean
my testing branch with modified scmi-cpufreq.c.


On 11/10/20 9:59 AM, Lukasz Luba wrote:
> Hi Daniel,
> 
> I've experimented with the patch set and went through the code again.
> It looks good, only a few minor comments.
> 
> On 10/6/20 1:20 PM, Daniel Lezcano wrote:
>> On the embedded world, the complexity of the SoC leads to an
>> increasing number of hotspots which need to be monitored and mitigated
>> as a whole in order to prevent the temperature to go above the
>> normative and legally stated 'skin temperature'.

[snip]

>> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
>> new file mode 100644
>> index 000000000000..6696bdcfdb87
>> --- /dev/null
>> +++ b/include/linux/dtpm.h
>> @@ -0,0 +1,73 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2020 Linaro Ltd
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + */
>> +#ifndef ___DTPM_H__
>> +#define ___DTPM_H__
>> +
>> +#include <linux/of.h>
>> +#include <linux/powercap.h>
>> +
>> +#define MAX_DTPM_DESCR 8
>> +#define MAX_DTPM_CONSTRAINTS 1
>> +
>> +struct dtpm {
>> +    struct powercap_zone zone;
>> +    struct dtpm *parent;
>> +    struct list_head sibling;
>> +    struct list_head children;
>> +    spinlock_t lock;
>> +    u64 power_limit;
>> +    u64 power_max;
>> +    u64 power_min;
>> +    int weight;
>> +    void *private;
>> +};
>> +
>> +struct dtpm_descr;
>> +
>> +typedef int (*dtpm_init_t)(struct dtpm_descr *);
>> +
>> +struct dtpm_descr {
>> +    struct dtpm *parent;
>> +    const char *name;
>> +    dtpm_init_t init;
>> +};
>> +
>> +/* Init section thermal table */
>> +extern struct dtpm_descr *__dtpm_table[];
>> +extern struct dtpm_descr *__dtpm_table_end[];
>> +
>> +#define DTPM_TABLE_ENTRY(name)            \
>> +    static typeof(name) *__dtpm_table_entry_##name    \
>> +    __used __section(__dtpm_table) = &name
> 
> I had to change the section name to string, to pass compilation:
> __used __section("__dtpm_table") = &name
> I don't know if it's my compiler or configuration.
> 
> I've tried to register this DTPM in scmi-cpufreq.c with macro
> proposed in patch 4/4 commit message, but I might missed some
> important includes there...
> 
>> +
>> +#define DTPM_DECLARE(name)    DTPM_TABLE_ENTRY(name)
>> +
>> +#define for_each_dtpm_table(__dtpm)    \
>> +    for (__dtpm = __dtpm_table;    \
>> +         __dtpm < __dtpm_table_end;    \
>> +         __dtpm++)
>> +
>> +static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
>> +{
>> +    return container_of(zone, struct dtpm, zone);
>> +}
>> +
>> +int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max);
>> +
>> +int dtpm_release_zone(struct powercap_zone *pcz);
>> +
>> +struct dtpm *dtpm_alloc(void);
>> +
>> +void dtpm_unregister(struct dtpm *dtpm);
>> +
>> +int dtpm_register_parent(const char *name, struct dtpm *dtpm,
>> +             struct dtpm *parent);
>> +
>> +int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm 
>> *parent,
>> +          struct powercap_zone_ops *ops, int nr_constraints,
>> +          struct powercap_zone_constraint_ops *const_ops);

This header is missing
#ifdef CONFIG_DTPM with static inline functions and empty DTPM_DECLARE()
macro.
I got these issues, when my testing code in scmi-cpufreq.c was compiled
w/o CONFIG_DTPM and DTPM_CPU

/usr/bin/aarch64-linux-gnu-ld: warning: orphan section `__dtpm_table' 
from `drivers/cpufreq/scmi-cpufreq.o' being placed in section 
`__dtpm_table'.
/usr/bin/aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
/usr/bin/aarch64-linux-gnu-ld: Unexpected run-time procedure linkages 
detected!
drivers/cpufreq/scmi-cpufreq.o: In function `dtpm_register_pkg':
/data/linux/drivers/cpufreq/scmi-cpufreq.c:272: undefined reference to 
`dtpm_alloc'
/data/linux/drivers/cpufreq/scmi-cpufreq.c:276: undefined reference to 
`dtpm_register_parent'
/data/linux/drivers/cpufreq/scmi-cpufreq.c:280: undefined reference to 
`dtpm_register_cpu'
Makefile:1164: recipe for target 'vmlinux' failed


The diff bellow fixed my issues. Then I had one for patch 4/4
for static inline int dtpm_register_cpu() function. I've followed the
thermal.h scheme with -ENODEV, but you can choose different approach.
--------------------------8<---------------------------------------------
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 6696bdcfdb87..0ef784ca5d0b 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -40,6 +40,7 @@ struct dtpm_descr {
  extern struct dtpm_descr *__dtpm_table[];
  extern struct dtpm_descr *__dtpm_table_end[];

+#ifdef CONFIG_DTPM
  #define DTPM_TABLE_ENTRY(name)			\
  	static typeof(name) *__dtpm_table_entry_##name	\
  	__used __section(__dtpm_table) = &name
@@ -70,4 +71,36 @@ int dtpm_register_parent(const char *name, struct 
dtpm *dtpm,
  int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm 
*parent,
  		  struct powercap_zone_ops *ops, int nr_constraints,
  		  struct powercap_zone_constraint_ops *const_ops);
-#endif
+#else
+#define DTPM_DECLARE(name)
+static inline
+int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max)
+{
+	return -ENODEV;
+}
+static inline int dtpm_release_zone(struct powercap_zone *pcz)
+{
+	return -ENODEV;
+}
+static inline struct dtpm *dtpm_alloc(void)
+{
+	return ERR_PTR(-ENODEV);
+}
+static inline void dtpm_unregister(struct dtpm *dtpm)
+{ }
+static inline
+int dtpm_register_parent(const char *name, struct dtpm *dtpm,
+			 struct dtpm *parent)
+{
+	return -ENODEV;
+}
+static inline
+int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent,
+		  struct powercap_zone_ops *ops, int nr_constraints,
+		  struct powercap_zone_constraint_ops *const_ops)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_DTPM */
+
+#endif /* __DTPM_H__ */

----------------------------->8-------------------------------------------


>> +#endif
>>
> 
> Minor comment. This new framework deserves more debug prints, especially
> in registration/unregistration paths. I had to put some, to test it.
> But it can be done later as well, after it gets into mainline.
> 
> I have also run different hotplug stress tests to check this tree
> locking. The userspace process constantly reading these values, while
> the last CPU in the cluster was going on/off and node was detaching.
> I haven't seen any problems, but the tree wasn't so deep.
> Everything was calculated properly, no error, null pointers, etc.
> 
> Apart from the spelling minor issues and the long constraint name, LGTM
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Please ignore these two for a while. But if you decide to take this diff 
above, you can add these two tags then in v2.
This is the only issue that I see.

Regards,
Lukasz
